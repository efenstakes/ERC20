# Solidity Contracts (ERC20)

This project demonstrates development of blockchain contracts that use ERC20 standard both with and without openzeppelin. Hardhat is used as the management tool for compiling, testing and deployment.

TKO token was deployed to the blockchain, the transaction can be found in

https://rinkeby.etherscan.io/address/0xB49E2fDB0BDf2c2B60900bB5C3680aF818C5dd2d


Run these commanda to run some common hardhat tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy_token.js
```

# Etherscan verification
To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/deploy_token.js
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS
```

