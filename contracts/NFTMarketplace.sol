// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MobiloitteCoin.sol";


contract ColorNFT is Ownable
{
    // The price to create new colorNFT
    uint256 public _mintingPrice;

    // The currency to create new colorNFT
    MobiloitteCoin public _mintingCurrency;

    mapping(uint256 => bytes3) tokens;
    mapping(uint256 => address) owners;

    // map for sale tokens from tokenId => tokenPrice;
    mapping(uint256 => uint256) forSale;

    // map for mint tokens from tokenId => tokenPrice;
    mapping(uint256 => uint256) forMint;

    function mintingPrice() external view returns (uint256) {
        return _mintingPrice;
    }

    function mintingCurrency() external view returns (MobiloitteCoin) {
        return _mintingCurrency;
    }

    function setMintingPrice(uint256 newMintingPrice) onlyOwner external {
        _mintingPrice = newMintingPrice;
    }

    function setMintingCurrency(MobiloitteCoin newMintingCurrency) onlyOwner external {
        _mintingCurrency = newMintingCurrency;
    }

    function mint(bytes3 colorNFT, uint256 tokenId) public {
        require(tokens[tokenId] == 0, "Token with the id already exists");
        tokens[tokenId] = colorNFT;
        owners[tokenId] = msg.sender;
        forMint[tokenId] = _mintingPrice;
    }

    function getTokenPrice(uint256 tokenId) public view returns(uint256 TokenPrice) {
        return forSale[tokenId];
    }

    function sellToken(uint256 tokenId, uint256 price) public {
        require(
            owners[tokenId] == msg.sender,
            "Only owners can send the tokens"
        );

        require(forSale[tokenId] == 0, "the token  is already for sale");
        forSale[tokenId] = price;
    }

    function buyToken(address _addr, uint256 tokenId) public {

        MobiloitteCoin mobiloittecoin = MobiloitteCoin(_addr);

        uint256 tokenPrice = forSale[tokenId];
        require(tokenPrice != 0, "the token is not for sale");
        require(
            mobiloittecoin.balanceOf(msg.sender) >= tokenPrice,
            "the provided amount is not sufficient"
        );
        require(
            msg.sender != owners[tokenId],
            "the message sender is already the owner of the token"
        );

        // return mobiloittecoin.balanceOf(msg.sender);
        mobiloittecoin.approve(address(this), tokenPrice);
        mobiloittecoin.transferFrom(msg.sender, owners[tokenId], tokenPrice);
    }

    function getTokenInfo(uint256 tokenId)
        public
        view
        returns (bytes3 colorToken)
    {
        return tokens[tokenId];
    }
}
