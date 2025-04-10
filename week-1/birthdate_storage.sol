// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//pragma solidity >=0.8.0 <0.9.0;

contract BirthdateStorage {

    struct Person {
        uint256 birthDate;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToBirthDate;

    function addPerson(string memory _name, uint256 _birthDate) public {
        listOfPeople.push(Person(_birthDate, _name));
        nameToBirthDate[_name] = _birthDate;
    }

}