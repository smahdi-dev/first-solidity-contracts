// get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// 756,827 tx gas before using constant
// 736,882 tx gas after using constant
// 713,699 tx gas after using immutable

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 347 gas constant
    // 2,446 gas non-constant

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    // 439 gas immutable
    // 2,574 gas non-immutable

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        // 1. how do we send ETH to these contracts

        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!"); // 1e18 == 1 * (10 ** 18)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

        // what is reverting?
        // undo any action before, and send remaining gas back
    }

    function withdraw() public onlyOwner {
        /* starting point, ending point, step amount */
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // withdraw the funds
        // transfer => throws error
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed!");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed!");
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "sender is not owner!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }
}
