// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library SillyStringUtils {

    struct Haiku {
        string line1;
        string line2;
        string line3;
    }

    function shruggie(string memory _input) internal pure returns (string memory) {
        return string.concat(_input, unicode" 🤷");
    }
}
// File: ImportExercise.sol



pragma solidity ^0.8.17;


contract ImportExercise {
    using SillyStringUtils for SillyStringUtils.Haiku;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku(string memory _line1, string memory _line2, string memory _line3) public {
        haiku = SillyStringUtils.Haiku(
            _line1,
            _line2,
            _line3
        );
    }

    function getHaiku() external view returns(SillyStringUtils.Haiku memory){
        return haiku;
    }

    function shruggieHaiku() external view returns(SillyStringUtils.Haiku memory){
        SillyStringUtils.Haiku memory copyHaiku = haiku;
        copyHaiku.line3 =  SillyStringUtils.shruggie(haiku.line3);
        return copyHaiku;
    }

}