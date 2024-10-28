// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//Haiku struct
struct Haiku {
    address author;
    string line1;
    string line2;
    string line3;
}

contract HaikuNFT is ERC721 {
    //use as id and track number of Haikus minted
    uint256 public counter;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {
        counter = 1;
    }

    //public array to store haikus
    Haiku[] public haikus;

    //error functions
    error HaikuNotUnique();
    error InvalidHaiku();
    error NotHaikuOwner();
    error NoHaikusShared();

    // Mapping to relate sharedHaikus from the address of the wallet shared with
    // to the id of the Haiku NFT shared
    mapping(address => uint256[]) public sharedHaikus;

    //mapping to check uniqueness of each line in a Haiku
    mapping(string => bool) private lineUsed;

    function mintHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external {
        //ensure uniqueness of each line
        if (lineUsed[_line1] || lineUsed[_line2] || lineUsed[_line3]) {
            revert HaikuNotUnique();
        }

        //make lines as used
        lineUsed[_line1] = true;
        lineUsed[_line2] = true;
        lineUsed[_line3] = true;

        //create and store the Haiku
        Haiku memory newHaiku = Haiku({
            author: msg.sender,
            line1: _line1,
            line2: _line2,
            line3: _line3
        });

        haikus.push(newHaiku);
        _safeMint(msg.sender, counter);
        counter++;
    }

    function shareHaiku(address _to, uint256 _haikuId) public {
        // Check if the Haiku ID is valid
        if (_haikuId >= haikus.length) {
            revert InvalidHaiku();
        }

        // Check if the sender is the owner of the Haiku
        if (msg.sender != haikus[_haikuId].author) {
            revert NotHaikuOwner();
        }

        //Add the Haiku ID to the recipient's sharedHaikus
        sharedHaikus[_to].push(_haikuId);
    }

    function getMySharedHaikus() public view returns (uint256[] memory) {
        //get the Haikus shared with the caller
        uint256[] memory mySharedHaikus = sharedHaikus[msg.sender];

        //revert if no Haikus are shared
        if (mySharedHaikus.length == 0) {
            revert NoHaikusShared();
        }
        return mySharedHaikus;
    }
}
