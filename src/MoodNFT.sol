// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;
    enum Mood {HAPPY, SAD}
    mapping (uint256 => Mood) private s_tokenIdToMood;

    // error
    error MoodNFT__CannotFlipIfNotOwner();

    modifier isApprovedOrOwner(address spender, uint256 tokenId) {
        address owner = _ownerOf(tokenId);
        require(spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender), MoodNFT__CannotFlipIfNotOwner());   
        _;
    }

    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("Mood NFT", "MNFT") {
        s_tokenCounter = 0; 
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri; 
    }

    function mintNFT() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; 
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public isApprovedOrOwner(msg.sender, tokenId) {
        s_tokenIdToMood[tokenId] = s_tokenIdToMood[tokenId] == Mood.HAPPY ? Mood.SAD : Mood.HAPPY;
    }


    function tokenURI(uint256 tokenId) public view override returns (string memory) {
       return string(abi.encodePacked(_baseURI(), Base64.encode(generateTokenMetadata(tokenId))));
    }

    function getImageUriByMood(Mood mood) public view returns (string memory) {
        if (mood == Mood.HAPPY) {
            return s_happySvgImageUri;
        } else {
            return s_sadSvgImageUri;
        }
    }

    

    function generateTokenMetadata(uint256 tokenId) private view returns (bytes memory) {
        return abi.encodePacked('{"name": "', name(), '", "description": "An NFT that represents the mood of the owner",'
        , '"attributes": [{"trait_type": "moodiness", "value": 100}], "image": "', getImageUriByMood(s_tokenIdToMood[tokenId]) ,'"}');
    }

    function getMoodEnum(uint index) public pure returns (Mood) {
        return Mood(index);
    }
}

    