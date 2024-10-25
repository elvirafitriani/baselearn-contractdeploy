/**
 *Submitted for verification at sepolia.basescan.org on 2024-04-24
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract UnburnableToken {
        mapping (address => uint) public balances;
        mapping (address => bool) public hasClaimed;
        uint public totalSupply;
        uint public totalClaimed;
        uint private claimAmount = 1000;

        error TokensClaimed();
        error UnsafeTransfer(address);

        constructor(){
            totalSupply = 100_000_000;
        }

        function claim() public {
            if(hasClaimed[msg.sender]) {
                revert TokensClaimed();
            }
            require(totalClaimed <= totalSupply, "no more tokens left");
            balances[msg.sender]+= claimAmount;
            hasClaimed[msg.sender] = true;
            totalClaimed+= claimAmount;
        }

        function safeTransfer(address _to, uint _amount) public{
            if(_to==0x0000000000000000000000000000000000000000){
                revert UnsafeTransfer(_to);
            }

            if(_to.balance == 0){
                revert UnsafeTransfer(_to);
            }
            balances[msg.sender]-=_amount;
            balances[_to]+=_amount;
        }

}