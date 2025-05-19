// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {PubSalesRecord} from "../src/PubSalesRecord.sol";

contract PubSalesRecordTest is Test {
    PubSalesRecord public salesRecord;

    // 각 테스트 함수가 실행되기 전에 호출되는 초기 설정 함수
    function setUp() public {
        // PubSalesRecord 컨트랙트를 배포합니다.
        salesRecord = new PubSalesRecord();
    }
    // 테스트 1: 기본 판매 기록 및 상태 업데이트 테스트
    // recordSale 호출 시 totalRevenue와 totalItemsSold가 올바르게 업데이트되는지 확인
    function testRecordSale() public {
        // 초기 상태 확인
        assertEq(salesRecord.getTotalRevenue(), 0, "Initial total revenue should be zero");
        assertEq(salesRecord.getTotalItemsSold(), 0, "Initial total items sold should be zero");

        // 첫 번째 판매 기록 (Admission: 20)
        salesRecord.recordSale("Admission");

        // 첫 번째 판매 후 상태 확인
        assertEq(salesRecord.getTotalRevenue(), 20, "Total revenue incorrect after first sale");
        assertEq(salesRecord.getTotalItemsSold(), 1, "Total items sold incorrect after first sale");

        // 두 번째 판매 기록 (Odeng Soup: 10)
        salesRecord.recordSale("Odeng Soup");

        // 두 번째 판매 후 상태 확인
        assertEq(salesRecord.getTotalRevenue(), 30, "Total revenue incorrect after second sale"); // 20 + 10
        assertEq(salesRecord.getTotalItemsSold(), 2, "Total items sold incorrect after second sale"); // 1 + 1

        // 세 번째 판매 기록 (Odeng Soup: 10)
        salesRecord.recordSale("Odeng Soup");

        // 세 번째 판매 후 상태 확인
        assertEq(salesRecord.getTotalRevenue(), 40, "Total revenue incorrect after third sale"); // 30 + 10
        assertEq(salesRecord.getTotalItemsSold(), 3, "Total items sold incorrect after third sale"); // 2 + 1
    }

    // 테스트 2: 매출 50 달성 이벤트 테스트
    function testRevenueMilestone50Trigger() public {
        // 총 매출이 50 미만이 되도록 판매 기록
        // Admission(20) + Odeng Soup(10) + Steamed Eggs(3) + Sausage and Vegetable Stir-fry(12) = 45
        salesRecord.recordSale("Admission"); // 20
        salesRecord.recordSale("Odeng Soup"); // 10
        salesRecord.recordSale("Steamed Eggs"); // 3
        salesRecord.recordSale("Sausage and Vegetable Stir-fry"); // 12
        assertEq(salesRecord.getTotalRevenue(), 45, "Total revenue should be 45 before milestone");

        // 다음 판매(Odeng Soup: 10)로 총 매출이 45 + 10 = 55가 되어 50을 넘습니다.
        // 이 호출에서 RevenueMilestone50 이벤트가 발생할 것을 예상합니다.
        // vm.expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter)
        // RevenueMilestone50(uint totalRevenue) 이벤트는 인덱싱된 토픽이 없습니다 (Topic 0 제외).
        // 데이터는 totalRevenue (uint) 입니다.
        // emitter는 salesRecord 컨트랙트 주소입니다.
        // vm.expectEmit(true, true, false, true, address(salesRecord)); // 매개변수 수정

        // 50을 넘는 판매 기록
        salesRecord.recordSale("Odeng Soup"); // 50 달성!

        // 총 매출이 55가 되었는지 확인
        assertEq(salesRecord.getTotalRevenue(), 55, "Total revenue incorrect after milestone sale");
        assertEq(salesRecord.getTotalItemsSold(), 5, "Total items sold incorrect after milestone sale"); // 4 + 1
    }

}

