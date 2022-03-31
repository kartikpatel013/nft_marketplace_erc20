const MobiloitteCoin = artifacts.require("MobiloitteCoin");
const ColorNFT = artifacts.require("ColorNFT");

module.exports = function (deployer) {
  deployer.deploy(MobiloitteCoin, 10000);
  deployer.deploy(ColorNFT);
};
