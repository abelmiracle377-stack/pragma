// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {PragmaNFT} from "../src/PragmaNFT.sol";

contract PragmaNFTTest is Test {
    PragmaNFT nft;
    address minter = address(0xA11CE);
    address buyer = address(0xB0B);

    function setUp() public {
        nft = new PragmaNFT("Pragma NFT", "PRAGMA", "ipfs://example/");
    }

    function testSupportsERC721Interfaces() public {
        assertTrue(nft.supportsInterface(0x01ffc9a7));
        assertTrue(nft.supportsInterface(0x80ac58cd));
        assertTrue(nft.supportsInterface(0x5b5e139f));
        assertFalse(nft.supportsInterface(0xffffffff));
    }

    function testInitialState() public {
        assertEq(nft.name(), "Pragma NFT");
        assertEq(nft.symbol(), "PRAGMA");
        assertEq(nft.owner(), address(this));
        assertEq(nft.totalSupply(), 0);
    }

    function testMintAndTokenURI() public {
        uint256 tokenId = nft.mint(minter);
        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(tokenId), minter);
        assertEq(nft.balanceOf(minter), 1);
        assertEq(nft.totalSupply(), 1);
        assertEq(nft.tokenURI(tokenId), "ipfs://example/1.json");
    }

    function testTransferWithApproval() public {
        uint256 tokenId = nft.mint(minter);

        vm.prank(minter);
        nft.approve(buyer, tokenId);

        vm.prank(buyer);
        nft.transferFrom(minter, buyer, tokenId);

        assertEq(nft.ownerOf(tokenId), buyer);
        assertEq(nft.balanceOf(minter), 0);
        assertEq(nft.balanceOf(buyer), 1);
        assertEq(nft.getApproved(tokenId), address(0));
    }

    function testBurn() public {
        uint256 tokenId = nft.mint(minter);

        vm.prank(minter);
        nft.burn(tokenId);

        assertEq(nft.balanceOf(minter), 0);
        assertEq(nft.totalSupply(), 0);
    }

    function testUnauthorizedMintReverts() public {
        vm.prank(minter);
        vm.expectRevert(PragmaNFT.NotOwner.selector);
        nft.mint(minter);
    }

    function testUnauthorizedTransferReverts() public {
        uint256 tokenId = nft.mint(minter);

        vm.prank(buyer);
        vm.expectRevert(PragmaNFT.NotApproved.selector);
        nft.transferFrom(minter, buyer, tokenId);
    }

    function testBaseURIUpdate() public {
        nft.mint(minter);
        nft.setBaseURI("ipfs://new/");
        assertEq(nft.tokenURI(1), "ipfs://new/1.json");
    }
}
