// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

// import {IDStorage} from "./id_storage.sol"; when importing locally
import "https://github.com/Imjungjuna/blockchainStudy_2025-1/blob/main/week-2/code/id_storage.sol";

// Import OpenZeppelin's Strings utility
import "@openzeppelin/contracts/utils/Strings.sol";

contract AddSchoolYear is IDStorage {

    //IDStorage 상속받음, listOfPeople 같은 변수 명시 안해도 사용 가능.
    //변수 id를 string으로 받으먼 쉽지만, type conversion를 보이기 위한 예시

    using Strings for uint256;
    string public schoolYear = "2025";
    mapping(string => string) public nameToStudentId;


    function addPerson(string memory _name, uint256 _id) public override {
        nameToStudentId[_name] = string.concat(schoolYear,_id.toString());  
    }
}