// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
 
import {Test} from "forge-std/Test.sol";
import "../src/Bunker.sol";
import "../src/AttackChall1.sol";
 
contract Chall1Test is Test {
    Bunker public bunker;
    Attack public attackCont;

 
    function setUp() public {
        bunker= new Bunker(address(1));
        attackCont= new Attack(address(bunker));
    }

    
    function testUnlockBunker() public {
        deal(address(attackCont), 13);
        attackCont.attack();
        uint256 bunkerCode= bunker.codePart1();
        bunker.unlock(bunkerCode);
        bunker.EnterTheBunker();
        assertEq(bunker.solved(), true);

    }
    
}