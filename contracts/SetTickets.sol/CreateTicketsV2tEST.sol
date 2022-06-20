// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";


contract CreateTicketV2 is ERC721 {
  
    uint32 public nftSold = 0;
    address s_owner;
  
    constructor(
        string memory name_, string memory symbol_
    )
        ERC721(_name, _symbol)
    {
        s_owner = msg.sender;
    }



    function mint(uint32 numNfts) public onlyOwner {
         lotterytStart = this.totalSupply();
         nftSold = 0; 
         for (uint256 i = 0; i < numNfts; i++){
             this.mintTo(s_owner);
         }
         lotteryOpen = true;
    }


    function transferFrom (
        address from,
        address to,
        uint256 tokenId
    ) public override {
        ERC721Tradable.transferFrom(from, to, tokenId);

        if (from == s_owner) {
            nftSold++;

             if (this.balanceOf(s_owner) == 0) {
                 lotteryOpen = false;
                 requestRandomWords();
             }
        }
         emit TransferFrom(from, to, tokenId);
    }


  
 
}