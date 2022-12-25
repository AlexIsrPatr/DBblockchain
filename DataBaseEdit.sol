// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";

abstract contract DataBaseEdit {

    mapping (address => User) users;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "");
        _;
    }

    function setEmail(string memory newEmail, address id) external onlyOwner returns(uint8) {
        users[id].setEmail(newEmail);
        return 0;
    }
    function setLogin(string memory newLogin, address id) external onlyOwner returns(uint8) {
        users[id].setLogin(newLogin);
        return 0;
    }
    function setName(string memory newName, address id) external onlyOwner returns(uint8) {
        users[id].setName(newName);
        return 0;
    }
    function setAge(uint8 newAge, address id) external onlyOwner returns(uint8) {
        users[id].setAge(newAge);
        return 0;
    }
    function setPassword(uint256 oldPassword, uint256 newPassword, address id) external onlyOwner returns(uint8) {
        users[id].setPassword(oldPassword, newPassword);
        return 0;
    }
}
