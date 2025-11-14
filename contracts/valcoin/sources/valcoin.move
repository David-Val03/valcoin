module valcoin::valcoin;

use sui::coin;
use sui::url::new_unsafe_from_bytes;

public struct VALCOIN has drop {}

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

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, ctx.sender());
}
