// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract ErrorTriageExercise {
    /**
     * Finds the difference between each uint with its neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
    function diffWithNeighbor(
        uint256 _a,
        uint256 _b,
        uint256 _c,
        uint256 _d
    ) public pure returns (uint256[] memory) {
        uint256[] memory results = new uint256[](3);

        // Check for underflow before performing subtraction
        if (_a > _b) {
            results[0] = _a - _b;
        } else {
            results[0] = _b - _a;
        }

        if (_b > _c) {
            results[1] = _b - _c;
        } else {
            results[1] = _c - _b;
        }

        if (_c > _d) {
            results[2] = _c - _d;
        } else {
            results[2] = _d - _c;
        }

        return results;
    }

    /**
     * Changes the _base by the value of _modifier.  Base is always > 1000.  Modifiers can be
     * between positive and negative 100;
     */
     error ModifierCausesOverflow(uint _base, int _modifier);

    function applyModifier(
        uint _base,
        int _modifier
    ) public pure returns (uint) {
        if (_modifier > 0 && type(uint).max - _base < uint(_modifier)) {
            revert ModifierCausesOverflow(_base, _modifier);
        }
        return uint(int(_base) + _modifier);
    }

    /**
     * Pop the last element from the supplied array, and return the modified array and the popped
     * value (unlike the built-in function)
     */
    uint256[] arr;

    function popWithReturn() public returns (uint256) {
        require(arr.length > 0, "Array is empty");

        uint256 index = arr.length - 1;
        uint256 poppedValue = arr[index];

        // Remove the last element by resizing the array
        arr.pop();

        return poppedValue;
    }

    // The utility functions below are working as expected
    function addToArr(uint256 _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
}
