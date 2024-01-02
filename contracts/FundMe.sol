// get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {

    uint256 public minimumUsd = 50;

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        // 1. how do we send ETH to these contracts 
        
        require(msg.value >= minimumUsd, "Didn't send enough!"); // 1e18 == 1 * (10 ** 18)

        // what is reverting?
        // undo any action before, and send remaining gas back
    }

    // function withdraw() {}

}