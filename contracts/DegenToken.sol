// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    
    mapping(uint256 => uint256) private marketValue;

    constructor() ERC20("Degen", "DGN") {
        marketValue[1] = 125;
        marketValue[2] = 83;  
        marketValue[3] = 23;  
        marketValue[4] = 67;
        marketValue[5] = 156;  
        marketValue[6] = 9;
    }

    function mintDegen(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function getDegenBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokensTo(address _receiver, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        transferFrom(msg.sender, _receiver, amount);
    }

    function burnToken(uint256 amount)external {
         require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender,amount);
    }

     function gameStore() public pure returns (string[] memory) {
        string[] memory items = new string[](6);
        items[0] = " 1. Knight's Vow 125";
        items[1] = " 2. Runaan's Bow = 83";
        items[2] = " 3. Bloodthirster = 23";
        items[3] = " 4. Kraken Slayer 67";
        items[4] = " 5. Rabadon's Cap = 156";
        items[5] = " 6. Infinity Edge = 9";

        return items;
    }

    function redeemTokens(uint256 choice) external payable {
        require(choice >= 1 && choice <= 6, "Invalid selection");

        uint256 amountToRedeem = marketValue[choice];
        require(amountToRedeem > 0, "Invalid choice");

        require(balanceOf(msg.sender) >= amountToRedeem, "Insufficient balance");
        
        _transfer(msg.sender, owner(), amountToRedeem);
    }

}
