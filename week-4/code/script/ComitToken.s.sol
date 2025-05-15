// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ComitToken} from "../src/ComitToken.sol";

contract ComitTokenScript is Script {
    // 배포된 ComitToken 컨트랙트 주소를 저장할 변수 (선택 사항)
    ComitToken public comitToken;
    
    // 배포 전 초기 설정이 필요하다면 여기에 추가
    function setUp() public {}

    function run() public {
        // 배포 트랜잭션을 시작
        // 로컬 테스트넷(Anvil)에서는 기본 계정을 사용
        // 실제 네트워크 배포 시에는 vm.envUint("PRIVATE_KEY") 등을 사용하여 개인 키를 설정해야 함
        vm.startBroadcast();

        // ComitToken 컨트랙트를 배포
        comitToken = new ComitToken();

        // 배포 트랜잭션을 종료합니다.
        vm.stopBroadcast();

        // 배포된 컨트랙트 주소를 콘솔에 출력하여 확인 (선택 사항)
        console.log("ComitToken deployed to:", address(comitToken));
    }
}
