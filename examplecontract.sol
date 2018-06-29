pragma solidity ^0.4.21;

import "mortal.sol";
// can import contracts from GitHub
// import "github.com/ethereum/solidty/std/mortal.sol";"

// can use inheritance
contract MyContractExample is Mortal {
    
    uint myVar;
    
    mapping(address => Permission) myAddressMapping;
    
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    constructor() public payable {
        myVar = 5; // could set to whatever
        myAddressMapping[msg.sender] = Permission(true, 5); // set the mapping structure
    }
    
    function setMyVar(uint newVar) public onlyOwner {
        // only update global vars if contract owner is true
        myVar = newVar;
    }
    
    function getMyVar() public constant returns(uint) {
        return myVar;
    }
    
    function getContractOwner() public constant returns(address) {
        return owner;
    }
    
    function getMyContractBalance() public constant returns(uint) {
        return address(this).balance; // convert contract to address type to access balance
    }
    
    function () public payable {
        // anonymous fallback function
    }
    
}