// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import {IDStorage, SimpleStorage} from "./id_storage.sol";
// import {IDStorage} from "./id_storage.sol"; when importing locally
import "https://github.com/Imjungjuna/blockchainStudy_2025-1/blob/main/week-2/code/id_storage.sol";

contract StorageFactory {
    IDStorage[] public listOfIDStorageContracts;
    // address[] public listOfIDStorageAddresses;


    function createIDStorageContract() public {
        IDStorage newIDStorageContract = new IDStorage();
        listOfIDStorageContracts.push(newIDStorageContract);
        // listOfIDStorageAddresses.push(address(newIDStorageContract));
    }

    function sfAddPerson(
        uint256 _IDStorageIndex,
        string memory _IDStorageName,
        uint256 _IDStorageNumber
    ) public {
        // 외부 컨트랙트와 상호작용하기 위한 정보: Address + ABI
        //이 경우 IDStorage[] 속 요소가 contract type으로 두 정보 모두 포함(myIDStorage)

        IDStorage myIDStorage = listOfIDStorageContracts[_IDStorageIndex];
        myIDStorage.addPerson(_IDStorageName,_IDStorageNumber);

        //address를 contract type으로 타입 캐스팅해도 같은 결과
        // IDStorage myIDStorage = IDStorage(listOfIDStorageAddresses[_IDStorageIndex]);
    }

    function sfGetPerson(uint256 _IDStorageIndex, uint256 _PersonIndex) public view returns (uint256, string memory) {
        IDStorage myIDStorage = listOfIDStorageContracts[_IDStorageIndex];
        return myIDStorage.listOfPeople(_PersonIndex);

        //사람 이름으로도 아이디 조회 가능, 그럴려면...
        // _PersonIndex 대신 _PersonName, 리턴 값이 myIDStorage.nameToId(_PersonName);
    }
}