const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying MyToken contract with account:", deployer.address);

    const MyToken = await ethers.getContractFactory("ThangldToken");
    const myToken = await MyToken.deploy();

    console.log("MyToken contract deployed to address:", myToken.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });