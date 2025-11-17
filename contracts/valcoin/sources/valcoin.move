module valcoin::valcoin;

use sui::balance::Balance;
use sui::clock::{Self, Clock};
use sui::coin::{Self, TreasuryCap};
use sui::url::new_unsafe_from_bytes;

const EInvalidAmount: u64 = 0;
const ESupplyExceeded: u64 = 1;
const ETokenLocked: u64 = 2;

public struct VALCOIN has drop {}

public struct MintCapability has key {
    id: UID,
    treasury: TreasuryCap<VALCOIN>,
    total_minted: u64,
}

public struct Locker has key, store {
    id: UID,
    unlock_date: u64,
    balance: Balance<VALCOIN>,
}

const TOTAL_SUPPLY: u64 = 1_000_000_000_000_000_000;

const INITIAL_SUPPLY: u64 = 900_000_000_000_000_000;

#[allow(deprecated_usage)]
fun init(otw: VALCOIN, ctx: &mut TxContext) {
    let (treasury, metadata) = coin::create_currency(
        otw,
        9,
        b"VAL",
        b"VALCOIN",
        b"The Memecoin That's Out of This World!",
        option::some(
            new_unsafe_from_bytes(
                b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwsHBggIBwgKCgkLDRYPBwwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8QGjclHyU3Nzc3Nzc3MjE3Nzc3KzU3Nzc3KzAuODUzNzc3MDg3NTY3KzMtMjc4NSs3NCs1NS8tNf/AABEIABwAHAMBEQACEQEDEQH/xAAZAAACAwEAAAAAAAAAAAAAAAABBQACBAf/xAAlEAABBAECBQUAAAAAAAAAAAABAAIDEQQFMRMhQWFxEiNCYoH/xAAZAQADAQEBAAAAAAAAAAAAAAAAAQIFBAP/xAAgEQACAgEEAwEAAAAAAAAAAAAAAQIRAwQSQVEhYZEF/9oADAMBAAIRAxEAPwDiS9SAUihgISaACkZr02VkOZDJPG2SIH3Wvb6hR5bdt106aUY5E5q10RJWqH0emxYMszzFFMZZQzBY8BwAPMk77C+f17raWjhgbe1S3Oo39sGmYtZzYWvyMTHwscUfTxRG0OB61Q/Fx67NiUpYscF455BIRrJLLA0qToTGkGsyxcEljHmGIx45d8b6+aAHgLQh+hkjXNKl6C+xY42SSbJ3JXBJ2CKKBkQAbTEQoYASGf/Z",
            ),
        ),
        ctx,
    );
    let mut mint_cap = MintCapability {
        id: object::new(ctx),
        treasury,
        total_minted: 0,
    };

    mint(&mut mint_cap, INITIAL_SUPPLY, ctx.sender(), ctx);

    transfer::public_freeze_object(metadata);
    transfer::transfer(mint_cap, ctx.sender())
}

public fun mint(
    mint_cap: &mut MintCapability,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext,
) {
    let coin = mint_internal(mint_cap, amount, ctx);
    transfer::public_transfer(coin, recipient);
}

public fun mint_locked(
    mint_cap: &mut MintCapability,
    amount: u64,
    recipient: address,
    duration: u64,
    clock: &Clock,
    ctx: &mut TxContext,
) {
    let coin = mint_internal(mint_cap, amount, ctx);
    let start_date = clock.timestamp_ms();
    let unlock_date = start_date + duration;

    let locker = Locker {
        id: object::new(ctx),
        unlock_date,
        balance: coin::into_balance(coin),
    };

    transfer::public_transfer(locker, recipient);
}

entry fun withdraw_locked(locker: Locker, clock: &Clock, ctx: &mut TxContext): u64 {
    let Locker { id, mut balance, unlock_date } = locker;
    assert!(clock.timestamp_ms() >= unlock_date, ETokenLocked);

    let locked_balance_value = balance.value();

    transfer::public_transfer(
        coin::take(&mut balance, locked_balance_value, ctx),
        ctx.sender(),
    );

    balance.destroy_zero();
    object::delete(id);

    locked_balance_value
}

fun mint_internal(
    mint_cap: &mut MintCapability,
    amount: u64,
    ctx: &mut TxContext,
): coin::Coin<VALCOIN> {
    assert!(amount > 0, EInvalidAmount);
    assert!(mint_cap.total_minted + amount <= TOTAL_SUPPLY, ESupplyExceeded);

    let treasury = &mut mint_cap.treasury;

    let coin = coin::mint(treasury, amount, ctx);

    mint_cap.total_minted = mint_cap.total_minted + amount;
    coin
}

#[test_only]

use sui::test_scenario;

#[test]
fun test_init() {
    let publisher = @0x11;

    let mut scenario = test_scenario::begin(publisher);
    {
        let otw = VALCOIN {};
        init(otw, scenario.ctx());
    };

    scenario.next_tx(publisher);
    {
        let mint_cap = scenario.take_from_sender<MintCapability>();
        let valcoin = scenario.take_from_sender<coin::Coin<VALCOIN>>();

        assert!(mint_cap.total_minted == INITIAL_SUPPLY, EInvalidAmount);
        assert!(valcoin.balance().value() == INITIAL_SUPPLY, EInvalidAmount);

        scenario.return_to_sender(valcoin);
        scenario.return_to_sender(mint_cap);
    };

    scenario.next_tx(publisher);
    {
        let mut mint_cap = scenario.take_from_sender<MintCapability>();

        mint(
            &mut mint_cap,
            100_000_000_000_000_000,
            scenario.ctx().sender(),
            scenario.ctx(),
        );

        assert!(mint_cap.total_minted == TOTAL_SUPPLY, EInvalidAmount);
        scenario.return_to_sender(mint_cap);
    };
    scenario.end();
}

#[test]
fun test_lock_tokens() {
    let publisher = @0x11;
    let bob = @0xB0B;

    let mut scenario = test_scenario::begin(publisher);
    {
        let otw = VALCOIN {};
        init(otw, scenario.ctx());
    };

    scenario.next_tx(publisher);
    {
        let mut mint_cap = scenario.take_from_sender<MintCapability>();
        let duration = 5000;
        let test_clock = clock::create_for_testing(scenario.ctx());

        mint_locked(
            &mut mint_cap,
            100_000_000_000_000_000,
            bob,
            duration,
            &test_clock,
            scenario.ctx(),
        );

        assert!(mint_cap.total_minted == TOTAL_SUPPLY, EInvalidAmount);
        scenario.return_to_sender(mint_cap);
        test_clock.destroy_for_testing();
    };

    scenario.next_tx(bob);
    {
        let locker = scenario.take_from_sender<Locker>();
        let duration = 5000;
        let mut test_clock = clock::create_for_testing(scenario.ctx());
        test_clock.set_for_testing(duration);
        let amount = withdraw_locked(
            locker,
            &test_clock,
            scenario.ctx(),
        );
        assert!(amount == 100_000_000_000_000_000, EInvalidAmount);
        test_clock.destroy_for_testing();
    };

    scenario.next_tx(bob);
    {
        let coin = scenario.take_from_sender<coin::Coin<VALCOIN>>();
        assert!(coin.balance().value() == 100_000_000_000_000_000, EInvalidAmount);
        scenario.return_to_sender(coin);
    };
    scenario.end();
}
