// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {PragmaNFT} from "../src/PragmaNFT.sol";

contract PragmaNFTFuzzTest is Test {
    PragmaNFT internal nft;

    function setUp() public {
        nft = new PragmaNFT("Pragma NFT", "PRAGMA", "ipfs://collection/");
    }

    function testFuzzMintBalance(address recipient) public {
        vm.assume(recipient != address(0));

        uint256 tokenId = nft.mint(recipient);

        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(tokenId), recipient);
        assertEq(nft.balanceOf(recipient), 1);
        assertEq(nft.totalSupply(), 1);
    }

    function testFuzzMintMultiple(address first, address second) public {
        vm.assume(first != address(0));
        vm.assume(second != address(0));

        uint256 firstId = nft.mint(first);
        uint256 secondId = nft.mint(second);

        assertEq(firstId, 1);
        assertEq(secondId, 2);
        assertEq(nft.totalSupply(), 2);
        assertEq(nft.balanceOf(first) + nft.balanceOf(second), 2);
    }
}
