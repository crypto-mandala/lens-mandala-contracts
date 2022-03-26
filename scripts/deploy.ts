import { ethers } from "hardhat";

async function main() {
  const LensMandalaNFT = await ethers.getContractFactory("LensMandalaNFT");
  const lensMandalaNFT = await LensMandalaNFT.deploy("Hello, Hardhat!");

  await lensMandalaNFT.deployed();

  console.log("LensMandalaNFT deployed to:", lensMandalaNFT.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
