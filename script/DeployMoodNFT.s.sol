// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {  
    function run() external returns (MoodNFT) {
        string memory svg_happy = vm.readFile("./img/happy.svg");   
        string memory svg_sad = vm.readFile("./img/sad.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(svgToImageURI(svg_happy), svgToImageURI(svg_sad));
        vm.stopBroadcast();

        return moodNFT;
    }


    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64 = Base64.encode(bytes(svg));
        
        return string(abi.encodePacked(baseURL, svgBase64));
    }
}