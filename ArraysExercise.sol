// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[] private initialNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[] public timestamps;
    address[] public senders;

    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    function resetNumbers() public returns (uint[] memory) {
        numbers = initialNumbers;
        return numbers;
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K()
        external
        view
        returns (uint[] memory, address[] memory)
    {
        uint[] memory recentTimes;
        address[] memory recentSenders;
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        recentTimes = new uint[](count);
        recentSenders = new address[](count);
        count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                recentTimes[count] = timestamps[i];
                recentSenders[count] = senders[i];
                count++;
            }
        }

        return (recentTimes, recentSenders);
    }

    //reset storage variables
    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }
}
