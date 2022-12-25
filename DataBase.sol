// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";
import "./DataBaseEdit.sol";

contract DataBase is DataBaseEdit {

    constructor() {
        owner = msg.sender;
    }

    function addNewUser(string memory email, string memory login, uint256 password) public returns(uint8) {
        users[msg.sender] = new User(email, login, password, msg.sender);
        return 0;
    }

    function deleteUserByID(address id) public view returns(uint8) {
        if(msg.sender == owner)
            users[id].destruct;
        else 
            users[msg.sender].destruct; 
        return 0;
    }

    function getUserByID(address id) external view returns(User) {
        return users[id];
    }
}
