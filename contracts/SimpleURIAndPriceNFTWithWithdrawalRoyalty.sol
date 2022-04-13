// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./AbstractIncrementalMint.sol";
import "./AbstractNodPriceAndWithdrawal.sol";

contract SimpleURIAndPriceNFTWithWithdrawalRoyalty is
    AbstractIncrementalMint,
    AbstractNodPriceAndWithdrawal
{
    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI,
        uint256 priceInWei,
        uint256 maxSupply
    )
        AbstractIncrementalMint(name, symbol, baseURI, maxSupply)
        AbstractNodPriceAndWithdrawal(priceInWei)
    {}

    function mint() public payable requirePrice returns (uint256) {
        return _mintNextToken();
    }

    function setMaxSupply(uint256 newMaxSupply) public {
        return _setMaxSupply(newMaxSupply);
    }
}
