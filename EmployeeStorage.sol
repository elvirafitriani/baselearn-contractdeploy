// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract EmployeeStorage {
    string public name;
    uint16 private shares;
    uint24 private salary;
    uint256 public idNumber;

    constructor(
        string memory _name,
        uint16 _shares,
        uint24 _salary,
        uint256 _idNumber
    ) {
        name = _name;
        shares = _shares;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewSalary() public view returns (uint24) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public {
        uint16 totalShares = shares + _newShares;

        if (_newShares > 5000) {
            revert("Too many shares");
        }

        if (totalShares > 5000) {
            revert(string(abi.encodePacked("TooManyShares: ", totalShares)));
        }

        shares += _newShares;
    }

    function checkForPacking(uint256 _slot) public view returns (uint256 r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
