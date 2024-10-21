// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";


contract MintMoodNFT is Script {  
    function run() external {
      address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("MoodNFT", block.chainid);
        mintNFTOnContract(mostRecentDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNFT(contractAddress).mintNFT();
        vm.stopBroadcast();
    }
}
