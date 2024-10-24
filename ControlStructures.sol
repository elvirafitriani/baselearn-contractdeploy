// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ControlStructures {
    function fizzBuzz(uint _number) external pure returns (string memory) {
        if (_number % 3 == 0) {
            return "Fizz";
        }

        if (_number % 5 == 0) {
            return "Buzz";
        }

        if (_number % 15 == 0) {
            return "FizzBuzz";
        }

        return "Splat";
    }

    error AfterHours(uint _time);

    function doNotDisturb(uint _time) external pure returns (string memory) {
        assert(_time < 2400);

        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        if (_time >= 1200 && _time <= 1299) {
            revert("At lunch!");
        }

        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        }

        if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        }

        return "Evening!";
    }
}
