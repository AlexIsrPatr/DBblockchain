// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    string Email;
    string Login;
    uint256 Password;
    //address DataBaseAddress;
    string FullName;
    uint256 Age;

    constructor(string memory email, string memory login, uint256 password) {
    //    DataBaseAddress = msg.sender;
        Email = email;
        Login = login;
        Password = password;
    }

    function getEmail() external view returns(string memory) {
        return Email;
    }
    function getLogin() external view returns(string memory) {
        return Login;
    }
    function getName() external view returns(string memory) {
        return FullName;
    }
    //function getAddress() external view returns(address) {
    //    return DataBaseAddress;
    //}
    function getAge() external view returns(uint256) {
        return Age;
    }


    function setEmail(string memory newEmail) external returns(uint8) {
        Email = newEmail;
        return 0;
    }
    function setLogin(string memory newLogin) external returns(uint8) {
        Login = newLogin;
        return 0;
    }
    function setName(string memory newName) external returns(uint8) {
        FullName = newName;
        return 0;
    }
    function setAge(uint8 newAge) external returns(uint8) {
        if(newAge < 150 && newAge > 0) {
            Age = newAge;
            return 0;
        }
        return 1;
    }
    function setPassword(uint256 oldPassword, uint256 newPassword) external returns(uint8) {
        if(Password != newPassword && Password == oldPassword) {
            Password = newPassword;
            return 0;
        }
        if(Password != oldPassword) 
            return 1;
        if(Password == newPassword)
            return 2;
        return 255;
    }

    function isThisPasswordRight(uint256 password) external view returns(uint8) {
        if(password != Password) return 0;
        return 255;
    }
}