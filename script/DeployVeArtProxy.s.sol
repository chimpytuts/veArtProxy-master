// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {VeArtProxy} from "../src/VeArtProxy.sol";

contract DeployVeArtScriptProxy is Script {
    VeArtProxy public veArtProxy;
    // forge script DeployVeArtProxy.s.sol --rpc-url <RPC_URL> --verify --etherscan-api-key <ETHERSCAN_API_KEY> --broadcast
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        veArtProxy = new VeArtProxy(vm.envAddress("VE_SIX"));

        vm.stopBroadcast();
    }
}
