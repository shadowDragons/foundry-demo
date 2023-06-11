// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Faucet.sol";

contract FaucetTest is Test {
    Faucet public faucet;

    function setUp() public {
        faucet = new Faucet();
    }

    function testWithdrawal() public {
        address payable testAddr = payable(msg.sender);
        uint initialBalance = address(testAddr).balance;

        uint withdrawalAmount = 1000000000000000; // 0.001 ether
        uint expectedBalance = initialBalance + withdrawalAmount;

        address payable faucetPayable = payable(address(faucet));
        faucetPayable.transfer(1 ether);

        faucet.withdraw(testAddr);
        
        uint newBalance = address(testAddr).balance;
        assertEq(newBalance, expectedBalance, "Withdrawal amount not received.");
    }
}
