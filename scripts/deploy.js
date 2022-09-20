// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

    // Wer get the contract to deploy
    const horoscopeNFT = await hre.ethers.getContractFactory("horoscopeNFT");
    const hscp = await horoscopeNFT.deploy();   
    await hscp.deployed();
	
	//since we are testing, you should mention your own Eth wallet address
    const myAddress="0x2EEDEEb53645acB5fD23E02D483bE22541831923";
    console.log("horoscopeNFT deployed to:", hscp.address);   

    let txn = await hscp.mintNFT(myAddress, 'virgo');
    await txn.wait();

 }

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
