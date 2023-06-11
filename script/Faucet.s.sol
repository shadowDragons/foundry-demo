// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Faucet.sol";

contract FaucetScript is Script {
    function setUp() public {}

    function run() public {
        // 开始记录脚本中合约的调用和创建
        vm.startBroadcast();
        //生成合约对象
        Faucet c = new Faucet();
        // 结束记录
        vm.stopBroadcast(); 
    }
}
