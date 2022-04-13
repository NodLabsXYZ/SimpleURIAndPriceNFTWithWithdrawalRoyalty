// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../AbstractIncrementalMint.sol";

contract IncrementalMintMock is AbstractIncrementalMint {
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI,
        uint256 maxSupply
    ) AbstractIncrementalMint(name, symbol, baseURI, maxSupply) {}

    function mint() public payable returns (uint256) {
        return _mintNextToken();
    }

    function setMaxSupply(uint256 newMaxSupply) public {
        return _setMaxSupply(newMaxSupply);
    }
}
