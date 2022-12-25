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

    constructor(string memory email_, string memory login_, uint256 password_, address userAddress_) {
        dataBaseAddress = msg.sender;
        emit changeAddress("dataBaseAddress", dataBaseAddress, block.timestamp);
        userAddress = userAddress_;
        emit changeAddress("userAddress", userAddress, block.timestamp);
        password = password_;
        emit changeNum("password", password, block.timestamp);
        email = email_;
        emit changeString("email", email, block.timestamp);
        login = login_;
        emit changeString("login", login, block.timestamp);
    }

    modifier ownerContractOnly {
        require(msg.sender == dataBaseAddress || msg.sender == userAddress, 
            "");
        _;
    }

    event changeAddress (
        string changed,
        address newValue,
        uint256 timestamp
    );
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


    function setEmail(string memory newEmail) external ownerContractOnly returns(uint8) {
        email = newEmail;
        emit changeString("email", email, block.timestamp);
        return 0;
    }
    function setLogin(string memory newLogin) external ownerContractOnly returns(uint8) {
        login = newLogin;
        emit changeString("login", login, block.timestamp);
        return 0;
    }
    function setName(string memory newName) external ownerContractOnly returns(uint8) {
        fullName = newName;
        emit changeString("fullName", fullName, block.timestamp);
        return 0;
    }
    function setAge(uint8 newAge) external ownerContractOnly returns(uint8) {
        if(newAge < 150 && newAge > 0) {
            age = newAge;
            emit changeNum("age", age, block.timestamp);
            return 0;
        }
        return 1;
    }
    function setPassword(uint256 oldPassword, uint256 newPassword) external ownerContractOnly returns(uint8) {
        if(password != newPassword && password == oldPassword) {
            password = newPassword;
            emit changeNum("password", password, block.timestamp);
            return 0;
        }
        if(password != oldPassword) 
            return 1;
        if(password == newPassword)
            return 2;
        return 255;
    }

    function isThisPasswordRight(uint256 password_) external ownerContractOnly view returns(uint8) {
        if(password != password_) return 0;
        return 255;
    }

    function setUserAddress(address id) external {
        require(msg.sender == dataBaseAddress, "");
        userAddress = id;
        emit changeAddress("userAddress", userAddress, block.timestamp);
    }

    function destruct() external ownerContractOnly {
        selfdestruct(payable(userAddress));
    }
}