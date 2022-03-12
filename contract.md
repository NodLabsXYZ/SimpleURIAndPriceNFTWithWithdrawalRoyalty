This contract allows for NFTs to be minted for a price, set by "PriceInWei" in the constructor.

- `Name`: The name of your contract
  - This can be anything you want.
  - Example: CoolCatsContract
- `Symbol`: A symbol for your contract, similar to a stock ticker
  - This can be anything you want.
  - Example: CATS
- `BaseURI`: The base URI for your assets
  - This can be derived from the arweave uploader tool.
  - Example: https://arweave.net/ree7K2412t0Io6Mv8A3e6DqL_jogEM9Oainu9VRn8yQ
- `PriceInWei`: The price for minting an NFT in WEI
  - The minter will pay this + the gas fee. You will receive this amount for each minting.
  - Example: 1000000000000000000 (1 ETH)
