// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//ERC20 토큰을 라이브러리 없이 직접 만드는 예시

interface ERC20Interface {
    function totalSupply() external view returns(uint);
    function balanceOf(address account) external view returns(uint balance);
    function allowance(address owner, address spender) external view returns(uint remaining);
    function transfer(address receiver, uint amount) external returns(bool success);
    function approve(address spender, uint amount) external returns(bool success);
    function transferFrom(address spender, address receiver, uint amount) external returns(bool success);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract ComitToken is ERC20Interface {
    string public symbol;
    string public name;
    uint8 public decimals;
    uint public _totalSupply;

    mapping(address => uint) balance;
    mapping(address => mapping(address=>uint)) _allowance;
    address public deployer;

    //생성자 정보를 바탕으로 scan사이트 및 metamask 등에서 토큰으로 인식
    constructor() {
        symbol = "CMT";
        name = "Comit Coin";
        decimals = 18;
        _totalSupply = 1_000_001 * (10 ** decimals);
        deployer = msg.sender;
        balance[deployer] = _totalSupply ;
        emit Transfer(address(0), deployer, _totalSupply);
    }

    //초기 배포자만 권한 부여하는 모디파이어
    modifier onlyOwner() {
        require(msg.sender == deployer, "Not contract owner");
        _;
    }

    //토큰의 총 발행량을 조회
    function totalSupply() public view returns(uint) {
        return _totalSupply;
    }

    //특정 주소의 토큰 잔액을 조회
    function balanceOf(address account) public view returns(uint) {
        return balance[account];
    }

    //특정 주소로 토큰 전송(호출한 사람의 지갑에서)
    function transfer(address receiver, uint amount) public returns(bool success) {
        require(msg.sender != receiver);
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    //초기 배포자에 한해서 원하는 양만큼 토큰을 발행
    function mint(address to, uint amount) public onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        balance[to] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    //내가 가진 토큰 원하는 양만큼 소각
    function burn(uint amount) public {
        require(balance[msg.sender] >= amount, "Insufficient balance to burn");
        balance[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    //함수를 호출하는 주소의 토큰을 spender(주소)가 특정 양만큼 사용하도록 허락
    function approve(address spender, uint amount) public returns(bool success) {
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    //sender를 대리해서 특정 양만큼의 토큰을 보냄
    function transferFrom(address sender, address receiver, uint amount) public returns(bool success){
        require(_allowance[sender][msg.sender] >= amount);
        balance[sender] -= amount;
        _allowance[sender][msg.sender] -= amount;
        balance[receiver] += amount;
        emit Transfer(sender, receiver, amount);
        return true;
    }

    //owner 주소의 잔액 중 spender(보통 컨트랙트 주소)가 대리하여 사용가능한 토큰의 양을 조회
    function allowance(address owner, address spender) public view returns (uint remaining){
        return _allowance[owner][spender];
    }

}