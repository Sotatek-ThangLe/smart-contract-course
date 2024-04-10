require('dotenv').config()
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    bsc_testnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`, // BSC testnet RPC URL
      chainId: 97,
      gasPrice: 20000000000,
      accounts: {
        mnemonic: process.env.MNEMONIC
      }
    }
  }
};

export default config;
