// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract FlipMoodNFT is Script{
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid);
        flipMoodOnContract(mostRecentDeployed);
    }

    function flipMoodOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNFT(contractAddress).flipMood(0);
        vm.stopBroadcast();
    }
}