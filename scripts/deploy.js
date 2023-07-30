const hre = require("hardhat");

async function main() {
  // Get the Points smart contract
  const Degen = await hre.ethers.getContractFactory("DegenToken");

  // Deploy it
  const degen = await Degen.deploy();
  await degen.deployed();

  // Display the contract address
  console.log("Degen token deployed to:", degen.address);

  // Verify on Avalanche Fuji testnet
  if (hre.network.name === "fuji") {
    await hre.run("verify:verify", {
      address: degen.address,
      constructorArguments: [], // No constructor arguments needed
    });
  }
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });