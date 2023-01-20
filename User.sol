// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    uint256 password;
    uint256 age;
    address dataBaseAddress;
    address userAddress;
    string email;
    string login;
    string fullName;

    constructor(string memory email_, string memory login_, string memory password_, address userAddress_) {
        dataBaseAddress = msg.sender;
        userAddress = userAddress_;
        email = email_;
        emit changeString("email", email, block.timestamp);
        login = login_;
        emit changeString("login", login, block.timestamp);
        password = uint(keccak256(abi.encodePacked(password_)));
        emit changeNum("password", password, block.timestamp);
    }

    modifier ownerContractOnly {
        require(msg.sender == dataBaseAddress || msg.sender == userAddress);
        _;
    }

    event changeNum (
        string changed,
        uint256 newValue,
        uint256 timestamp
    );
    event changeString (
        string changed,
        string newValue,
        uint256 timestamp
    );

    function getEmail() external view returns(string memory) {
        return email;
    }
    function getLogin() external view returns(string memory) {
        return login;
    }
    function getName() external view returns(string memory) {
        return fullName;
    }
    function getDataBaseAddress() external view returns(address) {
       return dataBaseAddress;
    }
    function getUserAddress() external view returns(address) {
       return userAddress;
    }
    function getAge() external view returns(uint256) {
        return age;
    }


    function setEmail(string memory newEmail) external ownerContractOnly returns(uint256) {
        email = newEmail;
        emit changeString("email", email, block.timestamp);
        return 0;
    }
    function setLogin(string memory newLogin) external ownerContractOnly returns(uint256) {
        login = newLogin;
        emit changeString("login", login, block.timestamp);
        return 0;
    }
    function setName(string memory newName) external ownerContractOnly returns(uint256) {
        fullName = newName;
        emit changeString("fullName", fullName, block.timestamp);
        return 0;
    }
    function setAge(uint256 newAge) external ownerContractOnly returns(uint256) {
        if(newAge < 150 && newAge > 0) {
            age = newAge;
            emit changeNum("age", age, block.timestamp);
            return 0;
        }
        return 1;
    }
    function setPassword(string memory oldPassword, string memory newPassword) external ownerContractOnly returns(uint256) {
        if(password != uint(keccak256(abi.encodePacked(oldPassword)))) 
            return 1;
        if(password == uint(keccak256(abi.encodePacked(newPassword))))
            return 2;
        password = uint(keccak256(abi.encodePacked(newPassword)));
        emit changeNum("password", password, block.timestamp);
        return 0;
    }

    function destruct() external {
        require(msg.sender == dataBaseAddress);
        selfdestruct(payable(userAddress));
    }
}