pragma solidity ^0.4.21;


contract Mortal {
    
    address owner;
    
    // acts as a middleware-like function to wrap around other functions
    modifier onlyOwner() {
        if (owner == msg.sender) {
            _;
        } else {
            revert();
        }
    }
    
    constructor() public payable {
        owner = msg.sender;
    }
    
    // function to destroy the contract and return funds to owner
    function kill() public onlyOwner {
        selfdestruct(owner);
    }
}