// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistry {
    struct User {
        bool isRegistered;
        bytes32 passwordHash;
    }

    mapping(string => User) public users;

    event UserRegistered(address indexed userAddress);
    event UserAuthenticated(address indexed userAddress);

    function register(bytes32 _passwordHash) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        
        users[msg.sender] = User(true, _passwordHash);
        emit UserRegistered(msg.sender);
    }

    function authenticate(bytes32 _passwordHash) public view returns (bool) {
        User storage user = users[msg.sender];
        require(user.isRegistered, "User not registered");

        return (user.passwordHash == _passwordHash);
    }
}
