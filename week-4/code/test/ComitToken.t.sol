// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; // ERC20 컨트랙트와 동일한 pragma 버전 사용

import "forge-std/Test.sol"; // Foundry 테스트 기능을 사용하기 위한 import
import "../src/ComitToken.sol"; // 테스트할 ComitToken 컨트랙트 import (경로 확인 필요)

// 테스트 컨트랙트는 Test를 상속받습니다.
contract ComitTokenTest is Test {
    ComitToken public comitToken; // 배포될 ComitToken 컨트랙트 변수
    address public deployer; // 컨트랙트 배포자 주소 (테스트용 가상 계정)
    address public user1; // 테스트용 사용자 계정 1
    address public user2; // 테스트용 사용자 계정 2

    // 각 테스트 함수가 실행되기 전에 호출되는 초기 설정 함수
    // 여기서는 테스트에 사용할 가상 계정을 생성하고 ComitToken 컨트랙트를 배포
    function setUp() public {
        // vm.addr(숫자)를 사용하여 테스트에 사용할 결정론적 가상 계정 주소를 생성
        // 숫자는 시드 역할을 하며, 같은 숫자는 항상 같은 주소를 생성
        deployer = vm.addr(123); // 배포자 계정
        user1 = vm.addr(1);     // 사용자 1
        user2 = vm.addr(2);     // 사용자 2

        // deployer 계정이 컨트랙트를 배포하도록 설정
        vm.startPrank(deployer); // 이제부터 deployer 주소로 트랜잭션을 보낸 것처럼 시뮬레이션
        comitToken = new ComitToken(); // ComitToken 컨트랙트를 배포
        vm.stopPrank(); // deployer 주소로 트랜잭션 보내는 시뮬레이션을 종료
    }

    // 과제 항목 a: 초기 발행량이 배포자에게 할당되었는가?
    function testInitialSupplyAssignedToDeployer() public view {
        // 예상 총 발행량 계산 (1,000,001 * 10^18)
        uint256 expectedTotalSupply = 1_000_001 * (10 ** comitToken.decimals());

        // 컨트랙트의 totalSupply() 함수 호출 결과가 예상 총 발행량과 같은지 확인
        assertEq(comitToken.totalSupply(), expectedTotalSupply, "Total supply mismatch");

        // 배포자(deployer)의 잔액이 예상 총 발행량과 같은지 확인
        assertEq(comitToken.balanceOf(deployer), expectedTotalSupply, "Initial supply not assigned to deployer");
    }

    // 과제 항목 b: 토큰 전송 기능(transfer)이 정상 작동하는가?
    function testTransfer() public {
        // 전송할 토큰 양 (예: 100 CMT)
        uint256 transferAmount = 100 * (10 ** comitToken.decimals());

        // 전송 전에 deployer의 초기 잔액을 저장합니다.
        uint256 initialDeployerBalance = comitToken.balanceOf(deployer);

        // deployer가 user1에게 토큰을 전송하는 시뮬레이션
        vm.startPrank(deployer); // deployer 주소로 트랜잭션 실행
        bool success = comitToken.transfer(user1, transferAmount);
        vm.stopPrank(); // 시뮬레이션 종료

        // transfer 함수가 true를 반환했는지 확인
        assertTrue(success, "Transfer failed");

        // 전송 후 deployer의 잔액이 예상대로 감소했는지 확인
        assertEq(comitToken.balanceOf(deployer), initialDeployerBalance - transferAmount, "Deployer balance incorrect after transfer");

        // 전송 후 user1의 잔액이 예상대로 증가했는지 확인
        assertEq(comitToken.balanceOf(user1), transferAmount, "User1 balance incorrect after transfer");

        // user1이 deployer에게 전송 시도 (ComitToken의 transfer는 msg.sender != receiver 체크)
        // 이 경우 require(msg.sender != receiver)에 걸려 실패해야 합니다.
        vm.startPrank(user1); // user1 주소로 트랜잭션 실행
        comitToken.transfer(deployer, 1);
        vm.stopPrank();
    }

    // 과제 항목 C: mint()는 오직 배포자만 호출 가능한가?
    function testMintOnlyOwner() public {
        uint256 mintAmount = 500 * (10 ** comitToken.decimals()); // 발행할 토큰 양

        // 배포자(deployer)가 user1에게 mint 시도 (성공 예상)
        vm.startPrank(deployer); // deployer 주소로 트랜잭션 실행
        comitToken.mint(user1, mintAmount);
        vm.stopPrank(); // 시뮬레이션 종료

        // mint 성공 후 user1의 잔액이 증가했는지 확인
        assertEq(comitToken.balanceOf(user1), mintAmount, "Mint by deployer failed");

        // 배포자가 아닌 다른 주소(user1)가 user2에게 mint 시도 (실패 예상)
        vm.startPrank(user1); // user1 주소로 트랜잭션 실행
        // onlyOwner 모디파이어의 require 메시지와 일치하는지 확인
        vm.expectRevert("Not contract owner"); // 예상되는 에러 메시지 지정
        comitToken.mint(user2, mintAmount);
        vm.stopPrank(); // 시뮬레이션 종료
    }

    // 과제 항목 d: burn()은 본인 계정에서만 가능한가? (정확히는 호출한 계정의 잔액에서 소각)
    function testBurn() public {
        // burn 테스트를 위해 user1에게 일부 토큰을 미리 전송합니다.
        uint256 transferToUser1 = 200 * (10 ** comitToken.decimals());
        vm.startPrank(deployer);
        comitToken.transfer(user1, transferToUser1);
        vm.stopPrank();

        uint256 initialUser1Balance = comitToken.balanceOf(user1);
        uint256 burnAmount = 50 * (10 ** comitToken.decimals()); // 소각할 토큰 양

        // user1이 본인 토큰 burn 시도 (성공 예상)
        vm.startPrank(user1); // user1 주소로 트랜잭션 실행
        comitToken.burn(burnAmount);
        vm.stopPrank(); // 시뮬레이션 종료

        // burn 성공 후 user1의 잔액이 감소했는지 확인
        assertEq(comitToken.balanceOf(user1), initialUser1Balance - burnAmount, "Burn by user1 failed");

        // 잔액이 부족한 계정(user2)이 burn 시도 (실패 예상)
        uint256 user2Balance = comitToken.balanceOf(user2); // user2의 현재 잔액 (아마 0)
        uint256 burnAmountExceedingBalance = user2Balance + 1; // 잔액보다 많은 양
        vm.startPrank(user2); // user2 주소로 트랜잭션 실행
        // burn 함수의 require 메시지와 일치하는지 확인
        vm.expectRevert("Insufficient balance to burn"); // 예상되는 에러 메시지 지정
        comitToken.burn(burnAmountExceedingBalance);
        vm.stopPrank(); // 시뮬레이션 종료
    }

    // 과제 항목 e: approve()와 transferFrom() 기능이 잘 작동하는가?
    function testApproveAndTransferFrom() public {
        uint256 allowanceAmount = 200 * (10 ** comitToken.decimals()); // 허용할 토큰 양
        uint256 transferFromAmount = 150 * (10 ** comitToken.decimals()); // transferFrom으로 전송할 양

        // deployer가 user1(spender)에게 allowanceAmount 만큼 토큰 사용 권한 부여 (approve)
        vm.startPrank(deployer); // deployer 주소로 트랜잭션 실행
        bool approveSuccess = comitToken.approve(user1, allowanceAmount);
        vm.stopPrank(); // 시뮬레이션 종료

        // approve 함수가 true를 반환했는지 확인
        assertTrue(approveSuccess, "Approve failed");

        // deployer가 user1에게 부여한 allowance가 올바른지 확인
        assertEq(comitToken.allowance(deployer, user1), allowanceAmount, "Allowance amount incorrect after approve");

        // user1(spender)이 deployer(owner)의 토큰을 receiver(user2)에게 transferFrom 시도
        // transferFromAmount는 allowanceAmount보다 작아야 합니다.
        vm.startPrank(user1); // user1 주소로 트랜잭션 실행 (spender)
        // transferFrom을 성공하려면 owner(deployer)에게 transferFromAmount 이상의 잔액이 있어야 하고,
        // spender(user1)에게 owner(deployer)의 allowance가 transferFromAmount 이상이어야 합니다.
        // setUp에서 deployer는 전체 발행량을 가지고 있으므로 잔액은 충분합니다.
        bool transferFromSuccess = comitToken.transferFrom(deployer, user2, transferFromAmount);
        vm.stopPrank(); // 시뮬레이션 종료

        // transferFrom 함수가 true를 반환했는지 확인
        assertTrue(transferFromSuccess, "transferFrom failed");

        // transferFrom 후 deployer(owner)의 잔액이 예상대로 감소했는지 확인
        // 초기 잔액은 totalSupply와 같습니다.
        assertEq(comitToken.balanceOf(deployer), comitToken.totalSupply() - transferFromAmount, "Deployer balance incorrect after transferFrom");

        // transferFrom 후 user2(receiver)의 잔액이 예상대로 증가했는지 확인
        assertEq(comitToken.balanceOf(user2), transferFromAmount, "User2 balance incorrect after transferFrom");

        // transferFrom 후 deployer가 user1에게 부여한 allowance가 예상대로 감소했는지 확인
        assertEq(comitToken.allowance(deployer, user1), allowanceAmount - transferFromAmount, "Allowance incorrect after transferFrom");

        // --- allowance를 초과하는 transferFrom 시도 테스트 ---
        uint256 remainingAllowance = comitToken.allowance(deployer, user1);
        uint256 excessiveTransferAmount = remainingAllowance + 1; // 남은 allowance보다 1 큰 값

        // user1이 deployer의 토큰을 excessiveTransferAmount 만큼 transferFrom 시도 (실패 예상)
        vm.startPrank(user1); // user1 주소로 트랜잭션 실행 (spender)
        // transferFrom 함수의 require(_allowance[sender][msg.sender] >= amount)에 걸릴 것입니다.
        vm.expectRevert(); // 예상되는 에러 메시지 지정 가능 (require 메시지와 일치시키면 더 정확)
        comitToken.transferFrom(deployer, user2, excessiveTransferAmount);
        vm.stopPrank(); // 시뮬레이션 종료
    }
}
