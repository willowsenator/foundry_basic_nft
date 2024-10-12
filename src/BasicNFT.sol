// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping (uint256 => string) private s_tokenURIs;
    constructor() ERC721("BasicNFT", "BNFT") {
        s_tokenCounter = 0;   
    }

    function mintNFT(string memory uri) public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenURIs[s_tokenCounter] = uri;
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenURIs[tokenId];
    } 
}