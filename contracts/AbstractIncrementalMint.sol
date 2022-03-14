// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/utils/Counters.sol";

abstract contract AbstractIncrementalMint is ERC721 {
    event Minted(address indexed to, uint256 indexed tokenId, string uri);

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    string private _baseTokenURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "URI query for nonexistent token");

        string memory base = _baseURI();

        return
            string(abi.encodePacked(base, Strings.toString(tokenId), ".json"));
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function _mintNextToken() internal returns (uint256) {
        _tokenIdTracker.increment();
        uint256 tokenId = _tokenIdTracker.current();
        _safeMint(_msgSender(), tokenId);
        emit Minted(_msgSender(), tokenId, tokenURI(tokenId));
        return tokenId;
    }
}
