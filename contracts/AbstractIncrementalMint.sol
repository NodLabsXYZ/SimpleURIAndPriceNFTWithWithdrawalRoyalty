// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract AbstractIncrementalMint is ERC721, Ownable {
    uint256 public MAX_SUPPLY;
    
    event Minted(address indexed to, uint256 indexed tokenId, string uri);

    modifier shouldNotExceedMaxSupply() {
        require(_tokenIdTracker.current() < MAX_SUPPLY, "The maximum supply for this token has been reached.");
        _;
    }

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    string private _baseTokenURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI,
        uint256 maxSupply
    ) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
        MAX_SUPPLY = maxSupply;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function _mintNextToken() internal shouldNotExceedMaxSupply returns (uint256) {
        _tokenIdTracker.increment();
        uint256 tokenId = _tokenIdTracker.current();
        _safeMint(_msgSender(), tokenId);
        emit Minted(_msgSender(), tokenId, tokenURI(tokenId));
        return tokenId;
    }

    function _setMaxSupply(uint256 newMaxSupply) internal onlyOwner {
        MAX_SUPPLY = newMaxSupply;
    }
}
