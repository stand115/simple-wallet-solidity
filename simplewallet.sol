pragma solidity ^0.4.21;


import "browser/mortal.sol";

// inheritance is allowed
contract SimpleWallet is Mortal {
    
    // for mapping addresses to the Permission structure
    mapping(address => Permission) permittedAddresses;
    
    // used for logging in solidty
    event newWhitelistAddressLog(address creator, address newAddress, uint maxTransfer);
    event addressRemovedLog(address creator, address deleted);
    event fundsTransferedLog(address sender, address receiver, uint amountSent);
    
    // these are initialized by default, so we don't have to check if they are set/undefined
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyOwner {
        // only the owner is allowed to whitelist new addresses to send funds to
        permittedAddresses[permitted] = Permission(true, maxTransferAmount);
        
        // fire our event for logging
        emit newWhitelistAddressLog(msg.sender, permitted, maxTransferAmount);
    }
    
    function removeAddressFromSendersList(address toRemove) public onlyOwner {
        // only the owner is allowed to blacklist addresses
        delete permittedAddresses[toRemove];
        emit addressRemovedLog(msg.sender, toRemove);
    }
    
    function sendFunds(address receiver, uint amountInWei) public {
        // confirm that the address has been added to our mapping
        // could also use require(myAddressMapping[msg.sender].isAllowed);
        if (permittedAddresses[msg.sender].isAllowed) {
            
            // confirm that we are within the bounds of the max transfer amount
            if (permittedAddresses[msg.sender].maxTransferAmount >= amountInWei) {
                
                // address.transfer sends the funds and throws (reverts) on an error
                receiver.transfer(amountInWei);
                emit fundsTransferedLog(msg.sender, receiver, amountInWei);
            }
        }
    }
    
    // anonymous fallback function to fund the contract
    function () public payable {}
        
    
}