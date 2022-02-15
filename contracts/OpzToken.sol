// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract OpzToken is ERC20, Ownable {

    constructor(uint256 initialSupply) ERC20("OpzToken", "OTK") {
        _mint(msg.sender, initialSupply);
    }

    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


}