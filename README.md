# DegenToken Smart Contract

The DegenToken smart contract is an ERC20 token contract that represents the "Degen Gaming Token" (DG). It is designed to be used in gaming applications and supports basic token functionality like transfers, approvals, and burning tokens. Additionally, it includes a simple in-contract shop where players can purchase items using the Degen tokens.

## Contract Overview

### Token Information

- `Name:` Degen
- `Symbol:` DGN
- `Decimals:` 18
- `Total Supply:` 1,000,000 DGN (1 million DGN)

### Features

1. `Basic ERC20 Token:` Implements the ERC20 interface for standard token functionality.
2. `Minting :` The contract owner can only mint the tokens.
3. `Checking token balance:` Players can check their balance at any time .
4. `Burning tokens:` Anyone can be able to burn tokens, that they own, that are no longer needed.
5. `Shop Functionality:` The contract includes a basic shop where players can purchase items using Degen tokens.
6. `Transferring tokens:` Players are able to transfer their tokens to others.

## Deployment Process using Hardhat

**Follow the steps below to deploy the DegenToken contract to different networks using Hardhat:**

1. Clone the Repository

```bash
git clone https://github.com/punks783/ETH-AVAX_Module_4.git
cd ETH-AVAX_Module_4
```
2. Run `npm install` to install the required dependencies
3. Then check the `contracts/DegenToken.sol` solidity code that contains all the functions about the contract and game ! [including the SHOP items such as
`water`, `food` , `power` etc stuff .
4. Check the `hardhat.config.js` file and made necessary changes as by adding your custom rpc , Api keys , and wallet pvt keyys
5. After that run `npx hardhat run scripts/deploy.js --network fuji` to deploy on Avax testnet.
6. Then run `npx hardhat verify --network fuji 0x5B6ea0377e7f11669c82d8e986fa09A086417998` to verify
7. Once done you can interact with the contract through avax scan also ! 

