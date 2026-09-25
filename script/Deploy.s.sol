// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {PragmaNFT} from "../src/PragmaNFT.sol";

contract DeployPragmaNFT is Script {
    function run() external returns (PragmaNFT nft) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        nft = new PragmaNFT(
            vm.envString("NFT_NAME"),
            vm.envString("NFT_SYMBOL"),
            vm.envString("NFT_BASE_URI"),
            vm.envUint("NFT_MAX_SUPPLY"),
            uint96(vm.envUint("NFT_ROYALTY_BPS"))
        );
        vm.stopBroadcast();
    }
}
