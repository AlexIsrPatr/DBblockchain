// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./User.sol";

contract DataBase {

    address owner;
    User[] users;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "");
        _;
    }

    function getUsersIndexByID(address id) internal view returns(uint256) {
        if(users.length == 0)
            require(false, "There is no user");
        uint256 l = 0;
        uint256 r = users.length-1;
        while(l <= r) {
            if(users[(l+r)/2].getUserAddress() < id)
                l = (l+r)/2 + 1;
            else if(users[(l+r)/2].getUserAddress() > id && (l+r)/2 != 0)
                r = (l+r)/2 - 1;
            else
                return (l+r)/2;
        }
        require(false, "There is no user");
        return 0;
    }

    function getUserByID(address id) public view returns(User) {
        return users[getUsersIndexByID(id)];
    }

    function deleteUserByID(address id) public {
        uint256 i = getUsersIndexByID(id);
        getUserByID(id).destruct();
        for(i; i < users.length-1; i++)
            users[i] = users[i+1];
        users.pop();
    }
    
    function addNewUser(string memory email, string memory login, string memory password) public returns(uint256) {
        if(users.length == 0) {
            users.push(new User(email, login, password, msg.sender));
            return 0;
        }
        uint256 l = 0;
        uint256 r = users.length-1;
        while(l <= r) {
            if(users[(l+r)/2].getUserAddress() < msg.sender)
                l = (l+r)/2 + 1;
            else if(users[(l+r)/2].getUserAddress() > msg.sender && (l+r)/2 != 0)
                r = (l+r)/2 - 1;
            else
                return 1;
        }
        users.push(new User(email, login, password, msg.sender));
        uint256 i = users.length-1;
        for(i; i > r; i--) {
            User buffer = users[i];
            users[i] = users[i-1];
            users[i-1] = buffer;
        }
        return 0;
    }

    function setEmail(string memory newEmail, address id) external onlyOwner returns(uint256) {
        return getUserByID(id).setEmail(newEmail);
    }
    function setLogin(string memory newLogin, address id) external onlyOwner returns(uint256) {
        return getUserByID(id).setLogin(newLogin);
    }
    function setName(string memory newName, address id) external onlyOwner returns(uint256) {
        return getUserByID(id).setName(newName);
    }
    function setAge(uint256 newAge, address id) external onlyOwner returns(uint256) {
        return getUserByID(id).setAge(newAge);
    }
    function setPassword(string memory oldPassword, string memory newPassword, address id) external onlyOwner returns(uint256) {
        return getUserByID(id).setPassword(oldPassword, newPassword);
    }
}
