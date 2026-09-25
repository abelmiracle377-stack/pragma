// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {PragmaNFT} from "../src/PragmaNFT.sol";

contract ReceiverMock {
    bool public accept;
    constructor(bool accept_) { accept = accept_; }

    function onERC721Received(address, address, uint256, bytes calldata)
        external
        view
        returns (bytes4)
    {
        require(accept, "rejected");
        return 0x150b7a02;
    }
}

contract PragmaNFTSecurityTest is Test {
    PragmaNFT internal nft;
    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        nft = new PragmaNFT("Pragma NFT", "PRAGMA", "ipfs://collection/", 100, 500);
    }

    function testSafeTransferToReceiver() public {
        nft.mint(alice);
        ReceiverMock receiver = new ReceiverMock(true);

        vm.prank(alice);
        nft.safeTransferFrom(alice, address(receiver), 1);

        assertEq(nft.ownerOf(1), address(receiver));
    }

    function testSafeTransferRejectsBadReceiver() public {
        nft.mint(alice);
        ReceiverMock receiver = new ReceiverMock(false);

        vm.prank(alice);
        vm.expectRevert(PragmaNFT.UnsafeRecipient.selector);
        nft.safeTransferFrom(alice, address(receiver), 1);
    }

    function testOperatorCanTransfer() public {
        nft.mint(alice);

        vm.prank(alice);
        nft.setApprovalForAll(bob, true);

        vm.prank(bob);
        nft.transferFrom(alice, bob, 1);

        assertEq(nft.ownerOf(1), bob);
    }

    function testOwnerCanTransferOwnership() public {
        nft.transferOwnership(bob);
        assertEq(nft.owner(), bob);
    }

    function testOldOwnerCannotMintAfterOwnershipTransfer() public {
        nft.transferOwnership(bob);

        vm.expectRevert(PragmaNFT.NotOwner.selector);
        nft.mint(alice);
    }

    function testRoyaltyBoundary() public {
        nft.mint(alice);

        (, uint256 zeroRoyalty) = nft.royaltyInfo(1, 0);
        (, uint256 maxRoyalty) = nft.royaltyInfo(1, 10_000);

        assertEq(zeroRoyalty, 0);
        assertEq(maxRoyalty, 500);
    }
}
