// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/console.sol"; // console.log를 사용하기 위한 import

contract PubSalesRecord {
    // 총 매출을 저장하는 상태 변수
    uint public totalRevenue;

    // 팔린 상품의 총 개수를 저장하는 상태 변수
    uint public totalItemsSold;

    // 상품 이름별 가격을 저장하는 매핑
    mapping(string => uint) private itemPrices;

    // 매출 기록 시 로그를 남기는 이벤트
    // itemName과 currentTotalRevenue에 indexed 키워드를 추가하여 필터링 및 조회 용이성 향상
    event SaleRecorded(string indexed itemName, uint price, uint indexed currentTotalRevenue);

    // 매출 50 달성 시 발생하는 이벤트
    event RevenueMilestone50(uint totalRevenue); 

    constructor() {
        // 생성자에서 상품별 초기 가격 설정
        itemPrices["Admission"] = 20; // 입장
        itemPrices["Odeng Soup"] = 10; // 오뎅탕
        itemPrices["Steamed Eggs"] = 3; // 계란찜
        itemPrices["Sausage and Vegetable Stir-fry"] = 12; // 쏘시지 야채볶음
    }

    // 매출을 기록하는 함수 (상품 이름만 인자로 받음)
    function recordSale(string memory itemName) public {
        // 상품 가격 조회
        uint price = itemPrices[itemName];

        // 유효성 검사: 해당 상품이 존재하고 가격이 0보다 커야 함
        // 상품이 없으면 itemPrices[itemName]이 0이 됩니다.
        require(price > 0, "Invalid item or zero price");

        uint previousTotalRevenue = totalRevenue; // 매출 달성 체크를 위해 이전 총 매출 저장

        totalRevenue += price; // 총 매출에 더하기
        // itemRevenue[itemName] += price; // 특정 상품 매출 매핑 제거에 따라 이 라인 제거

        totalItemsSold += 1; // 팔린 상품 총 개수 1 증가 (새로 추가)

        // 매출 기록 이벤트 발생
        emit SaleRecorded(itemName, price, totalRevenue);

        // 총 매출이 50 이상이 되었고, 이전 총 매출은 50 미만이었으면 (50을 넘는 순간)
        if (totalRevenue >= 50 && previousTotalRevenue < 50) {
            // 콘솔 로그 출력 (Foundry 테스트 환경에서 확인 가능)
            console.log("Total revenue reached 50!");
            // 매출 달성 이벤트 발생
            emit RevenueMilestone50(totalRevenue);
        }
    }

    // 총 매출을 조회하는 함수 (view)
    function getTotalRevenue() public view returns (uint) {
        return totalRevenue;
    }

    // (선택 사항) 상품 가격을 조회하는 view 함수 (테스트 편의용)
    function getItemPrice(string memory itemName) public view returns (uint) {
        return itemPrices[itemName];
    }

    // 팔린 상품 총 개수를 조회하는 함수 (view)
    function getTotalItemsSold() public view returns (uint) {
        return totalItemsSold;
    }
}
