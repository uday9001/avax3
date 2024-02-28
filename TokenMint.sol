// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract TokenMint {

    string public tokenName;
    string public tokenSymbol;
    uint256 public totalSupply=10000;
    address public owner;

    mapping(address => uint256) public balance;

    constructor() {
        tokenName = "token";
        tokenSymbol = "TKN";
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action!");
        _;
    }

    function mint(address _recipient, uint256 _amount) public onlyOwner {
        // Increase the total supply
        totalSupply += _amount;
        // Increase the balance of the specified address
        balance[_recipient] += _amount;
    }

    function burn(uint256 _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        totalSupply -= _amount;
        balance[msg.sender] -= _amount;
    }

    function transfer(address _recipient, uint256 _amount) public {
        require(msg.sender != _recipient,"You can not transfer token(s) to yourself!");
        require(balance[msg.sender] >= _amount, "Transfer amount exceeds balance");
        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;
    }
}
