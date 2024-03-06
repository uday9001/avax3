// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpecialContract is ERC20 {

    mapping(address=>uint256) balance;

    event TranferedTo (uint256 indexed _value, address indexed _to);

    constructor(string memory _tokenName, string memory _symbol, uint256 _initialSupply) ERC20(_tokenName, _symbol) {
        _mint(msg.sender, _initialSupply);
    }

     function mint(address account, uint256 amount) external  {
        _mint(account, amount);
    }
    
    //function to enable transfer from the contract including a service fee of 10%
    function transferToken(uint256 _value, address _to) public returns(uint256){
        // uint256 coinSupply = totalSupply;
        require(balance[msg.sender] > _value, "You dont have enough SCT tokens in your account");
        require(_value > 0, "token amount must be greater than zero");
        require(msg.sender != address(0), "Check this address again. You cannnot send to this address!"); // performing a sanity check
        uint256 serviceFee = _value /10;
        balance[msg.sender] = balance[msg.sender] - serviceFee; // added service fee here
        balance[_to] = balance[_to] + _value; 
        
        emit TranferedTo(_value, _to);
        return balance[msg.sender];
    }

    function tokenBalance(address _address) public view returns(uint256){
        return balance[_address];
    }

    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }


}
