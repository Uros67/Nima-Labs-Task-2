// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/NotSoPriv8.sol";


contract MyScript is Script {
    // Counter public counter;
    NotSoPriv8 public notSoPriv8;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        notSoPriv8= new NotSoPriv8(bytes32(uint256(1234)));
        bytes32 slot0Value= vm.load(address(notSoPriv8), bytes32(uint256(0)));
        notSoPriv8.own(slot0Value);
        bool isPriv= notSoPriv8.locked();
        console.log(isPriv);
        vm.stopBroadcast();
    }
}
