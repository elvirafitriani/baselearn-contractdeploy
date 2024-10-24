// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract BasicMath {
    function adder(uint _a, uint _b) public pure returns (uint sum, bool error) {
        unchecked { 
            sum = _a + _b;
        }

        if (sum < _a || sum < _b) {
            return (0, true);
        }

        return (_a + _b, false);
    }

    function subtractor(uint _a, uint _b) public pure returns (uint difference, bool error) {
        unchecked { 
            difference = _a - _b;
        }

        if (difference > _a) {
            return (0, true);
        }

        return (_a - _b, false);
    }
}
