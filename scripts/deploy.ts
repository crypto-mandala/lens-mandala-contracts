import { ethers } from "hardhat";

async function main() {
  const LensMandalaNFT = await ethers.getContractFactory("LensMandalaNFT");
  const lensMandalaNFT = await LensMandalaNFT.deploy();

  await lensMandalaNFT.deployed();

  console.log("LensMandalaNFT deployed to:", lensMandalaNFT.address);

  const receiverAddress = "0x19908A43C5A69DF06F854B4f89BDb7B2DcA7746d";
  const url =
    "https://raw.githubusercontent.com/crypto-mandala/lens-mandala-contracts/main/metadata/metadata.json";
  await lensMandalaNFT.safeMint(receiverAddress, url);
  await lensMandalaNFT.safeMint(receiverAddress, url);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
