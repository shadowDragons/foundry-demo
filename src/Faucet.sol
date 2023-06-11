// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin-contracts/security/ReentrancyGuard.sol";
import "@openzeppelin-contracts/access/Ownable.sol";

contract Faucet is ReentrancyGuard, Ownable{
    uint public withdrawalLimit;
    mapping(address => uint) public lastWithdrawTime;

    event Withdrawal(address indexed recipient, uint amount, uint timestamp);

    constructor() {
        withdrawalLimit = 1000000000000000;
        
    }

    modifier canWithdraw(address payable _addr) {
        require(address(this).balance >= withdrawalLimit, "Insufficient contract balance.");
        require(block.timestamp - lastWithdrawTime[_addr] <= 1 days, "You can only withdraw once every 24 hours.");
        _;
    }

    function withdraw(address payable _addr) external payable nonReentrant canWithdraw(_addr) {
        lastWithdrawTime[_addr] = block.timestamp;
        require(_addr.send(withdrawalLimit), "Transfer failed.");
        emit Withdrawal(msg.sender, withdrawalLimit, block.timestamp);
    }

    function setWithdrawalLimit(uint limit) external onlyOwner {
        withdrawalLimit = limit;
    }

    function destroy() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {}
}