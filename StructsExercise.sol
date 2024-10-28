// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GarageManager {

    //car struct with properties
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    //list of cars indexed by address
    mapping(address => Car[]) public garage;

    //add car to user's collection
    function addCar(
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        Car memory newCar = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });

        garage[msg.sender].push(newCar);
    }

    //get cars by message sender
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    //get cars by inputted address
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    //update car
    function updateCar(
        uint _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        require(
            _index < garage[msg.sender].length,
            "BadCarIndex: Index out of range"
        );
        garage[msg.sender][_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }

    //reset garage
    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}
