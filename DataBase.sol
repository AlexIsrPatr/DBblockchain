// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";

contract DataBase {

    mapping (address => User) users;
    address owner;
    User Null = new User("", "", 0);

    constructor() {
        owner = msg.sender;
    }

    function addNewUser(string memory email, string memory login, uint256 password) public returns(uint8) {
        users[msg.sender] = new User(email, login, password);
        return 0;
    }

    function deleteUserByID(address id) public returns(uint8) {
        users[id] = Null;
        return 0;
    }

    function getUserByID(address id) external view returns(User) {
        return users[id];
    }
}
