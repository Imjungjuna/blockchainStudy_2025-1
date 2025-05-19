// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PubSalesRecord} from "../src/PubSalesRecord.sol";

contract PubSalesRecordScript is Script {
    
    PubSalesRecord public salesRecord;

    function run() public {
        // PubDailySalesRecord 컨트랙트를 배포
        salesRecord = new PubSalesRecord();

        // 배포된 컨트랙트 주소를 콘솔에 출력
        console.log("PubSalesRecord deployed to:", address(salesRecord));
    }
}
