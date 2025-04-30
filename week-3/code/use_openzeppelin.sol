// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//오픈제플린 라이브러리 사용해서 몇 줄의 코드만으로도 ERC20 토큰 생성하는 예시

contract ComitToken is ERC20 {
    constructor() ERC20("ComitToken", "CMT") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}