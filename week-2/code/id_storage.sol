// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//0.8.24 이상 버전부터 사용(그리고 0.9.0 이전)

contract IDStorage {

    struct Person {
        uint256 id; //6자리 숫자
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToId;

    function addPerson(string memory _name, uint256 _id) virtual public {
        listOfPeople.push(Person(_id, _name));
        nameToId[_name] = _id;
    }

}

contract SimpleStorage {}

contract ProfileStorage {}

