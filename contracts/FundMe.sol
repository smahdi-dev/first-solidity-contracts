// get funds from users
// withdraw funds
// set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 50 * 1e18;

    function fund() public payable {
        // want to be able to set a minimum fund amount in USD
        // 1. how do we send ETH to these contracts

        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough!"); // 1e18 == 1 * (10 ** 18)

        // what is reverting?
        // undo any action before, and send remaining gas back
    }

    function getPrice() public view returns (uint256) {
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        return uint256(price * 1e10); // 1**10
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice(); // ETH price in USD
        // 3000_000000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // function withdraw() {}
}
