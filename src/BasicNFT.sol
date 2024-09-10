// SPDX License Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract BasicContract is ERC721 {
    uint256 private s_tokenCounter;
    constructor() ERC721("BasicNFT", "BNFT") {
        s_tokenCounter = 0;   
    }

    function mintNFT() public {
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {

    } 
}