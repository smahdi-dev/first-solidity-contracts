// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample {
    uint256 public result;

    receive() external payable { 
        result = address(this).balance;
    }

    fallback() external payable { 
        result = 1;
    }
}