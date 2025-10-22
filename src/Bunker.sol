// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Bunker {
    bool public solved = false;
    bool public doorOpen = false;
    address public owner;
    uint256 public constant codePart1 = 13377331;

constructor(address _player) {
    owner = _player;
}

function EnterTheBunker() public {
    if (doorOpen) {
    solved = true;
    }
}

function unlock(uint256 code) public {
    require(code == codePart1, "Wrong code");
    require((address(this).balance) % 2 != 0, "Door is locked, you need to insert a coin");
    doorOpen = true;
}

receive() external payable {
    revert();
}

fallback() external payable {
    revert();
}

}