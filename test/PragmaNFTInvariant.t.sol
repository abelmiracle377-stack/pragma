// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {PragmaNFT} from "../src/PragmaNFT.sol";

contract PragmaNFTInvariantTest is Test {
    PragmaNFT internal nft;
    address internal constant ALICE = address(0xA11CE);
    address internal constant BOB = address(0xB0B);

    function setUp() public {
        nft = new PragmaNFT("Pragma NFT", "PRAGMA", "ipfs://collection/", 1000, 500);
    }

    function testInvariantSupplyMatchesKnownMintedSet() public {
        uint256 first = nft.mint(ALICE);
        uint256 second = nft.mint(BOB);

        assertEq(first, 1);
        assertEq(second, 2);
        assertEq(nft.totalSupply(), 2);
        assertEq(nft.balanceOf(ALICE), 1);
        assertEq(nft.balanceOf(BOB), 1);
    }
}
