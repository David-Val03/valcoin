import React from "react";
import { ConnectButton } from "@mysten/dapp-kit";

const NavBar: React.FC = () => {
  return (
    <nav className="bg-transparent flex flex-row justify-end items-end w-full p-4 shadow-md">
      <ConnectButton
        style={{
          backgroundColor: "transparent",
          color: "white",
          border: "1px solid white",
        }}
      />
    </nav>
  );
};

export default NavBar;
