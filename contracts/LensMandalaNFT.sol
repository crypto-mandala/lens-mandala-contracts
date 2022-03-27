// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LensMandalaNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Default: Toucan Protocol: Base Carbon Tonne on Mumbai
    address public buyTokenAddress = 0xf2438A14f668b1bbA53408346288f3d7C71c10a1;
    uint256 public buyPrice = 0.001 ether;
    address public buyTokenRecipientAddress = 0x6318b90Ab2BD2EfCe16B88f60b04747cE86ac185;

    constructor() ERC721("LensMandalaNFT", "NFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/crypto-mandala/lens-mandala-contracts/main/metadata/metadata.json?";
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function setBuyInfo(address tokenAddress, uint256 price, address recipientAddress) public onlyOwner {
        buyTokenAddress = tokenAddress;
        buyPrice = price;
        buyTokenRecipientAddress = recipientAddress;
    }

    function buy(address to) public {
        IERC20(buyTokenAddress).transferFrom(msg.sender, buyTokenRecipientAddress, buyPrice);
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
