// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../AbstractIncrementalMint.sol";

contract IncrementalMintMock is AbstractIncrementalMint {
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) AbstractIncrementalMint(name, symbol, baseURI) {}

    function mint() public payable returns (uint256) {
        return _mintNextToken();
    }
}
