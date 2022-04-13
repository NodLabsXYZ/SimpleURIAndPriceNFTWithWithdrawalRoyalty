const { expect } = require('chai');
const { expectEvent } = require('@openzeppelin/test-helpers');
const chai = require('chai')
const chaiAsPromised = require('chai-as-promised');
chai.use(chaiAsPromised).should();
const IncrementalMintMock = artifacts.require('IncrementalMintMock');

contract('AbstractIncrementalMint', ([owner, other, other2]) => {
  let contract, response1, response2;
  const initialMaxSupply = 5;

  beforeEach(async () => {
    contract = await IncrementalMintMock.new(
      "MyContract",
      "MCC",
      "https://arweave.net/arweave_hash_value",
      initialMaxSupply,
      { from: owner }
    );
    response1 = await contract.mint({ from: other })
    response2 = await contract.mint({ from: other2 })
  })

  it("properly constructs the full token uri on minting", async () => {
    const nonIndexURI = "https://arweave.net/arweave_hash_value"
    const tokenURI1 = await contract.tokenURI(1)
    expect(tokenURI1).to.equal(`${nonIndexURI}1`)

    const tokenURI2 = await contract.tokenURI(2)
    expect(tokenURI2).to.equal(`${nonIndexURI}2`)
  })

  it("emits a minted event", async () => {
    expectEvent(response1, 'Minted', {
      tokenId: "1",
      to: other,
      uri: "https://arweave.net/arweave_hash_value1"
    })

    expectEvent(response2, 'Minted', {
      tokenId: "2",
      to: other2,
      uri: "https://arweave.net/arweave_hash_value2"
    })
  })

  it('can get max supply', async () => {
    const actualMaxSupply = await contract.MAX_SUPPLY();

    expect(actualMaxSupply.toNumber()).to.eq(initialMaxSupply);
  });

  it('onlyOwner can set max supply', async () => {
    const newMaxSupply = 10;

    await contract.setMaxSupply(newMaxSupply);
    const actualMaxSupply = await contract.MAX_SUPPLY();

    expect(actualMaxSupply.toNumber()).to.eq(newMaxSupply);

    await contract.setMaxSupply(6, { from: other }).should.be.rejected;
  });

  it('should reject if trying to mint more than max supply', async () => {
    // Already minted 2
    for (let currentSupply = 2; currentSupply < initialMaxSupply; currentSupply++) {
      await contract.mint()
    }
    await contract.mint().should.be.rejected;
  });
})