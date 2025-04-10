# 블록체인 스터디 2주차

**안녕하세요!**

2주차에는 **트랜잭션 심화 분석 및 Solidity 입문(2)**을 다룹니다.
실제 블록체인 상호작용을 분석하는 능력을 키우는 것이 이번 주 목표이고, 지난 주에 이어
상속과 컨트랙트 객체 개념 등 기초적인 개발 지식을 쌓는 두번째 주라고 생각하시면 좋을 것 같습니다.

---

### **첫 번째 과제:** 트랜잭션 관련 개념 학습 **[Sepolia Testnet 기준]**

블록체인을 공부할 때, 개발 뿐만 아니라 생태계를 이해함에 있어 ‘트랜잭션’이라는 개념은 기본 구성 단위이자 빼놓을 수 없는 요소입니다. ’거래의 기록’이라는 피상적 개념을 넘어, 하나의 트랜잭션에 어떤 정보들이 포함되어 있고 각각의 정보들이 어떤 내용과 매커니즘으로 이루어져 있는지 파악하는 것은 좋은 개발자가 되기 위해 필수적인 수순입니다.

1. **트랜잭션 개념 파악하기**

https://www.youtube.com/watch?v=h1zkHIBFiS4&ab_channel=CryptoFinallyExplained

https://www.youtube.com/watch?v=qgqUkL4Yovc&ab_channel=%EB%85%B8%EB%A7%88%EB%93%9C%EC%BD%94%EB%8D%94NomadCoders

간단히 위의 두 동영상을 보고 트랜잭션에 관한 개념을 습득하시기 바랍니다.

1. **트랜잭션 Detail 학습하기**

개념을 습득한 이후에는 하나의 트랜잭션에 어떤 정보들이 포함되고, 어떻게 사용되는지 등을
학습할 차례입니다. Sepolia Testnet 이더스캔에 들어가셔서 트랜잭션에 어떤 정보들이 포함되는지, 각각의 의미가 무엇인지 찾아보시며 정리하시길 바랍니다.

[link ->](https://sepolia.etherscan.io/tx/0xfcf06b40a9b70bd7183b79234ac12900e52b5206d8ae20ed972baaee3ab8ace5)

1주차 스터디 시간에 실습하는 과정에서 `Add Person` 함수를 호출하였을 때 생성된 트랜잭션의
링크입니다. 해당 링크로 들어가 transaction detail을 살펴보며 학습하시기 바랍니다.

아래는 필수적으로 학습해야 하는 개념입니다.

- Basic Details - Transaction Hash, Status, Block Confirmation
- Transaction Fee - Gas price, Gas limit, Types of gas fee
- Other Attributes - EIP-1559, Nonce, Position in Block

학습하실 때 유용한 관련 참고 링크입니다.

https://updraft.cyfrin.io/courses/blockchain-basics/basics/introduction-to-gas

https://updraft.cyfrin.io/courses/blockchain-basics/basics/gas-in-depth

https://updraft.cyfrin.io/courses/blockchain-basics/basics/signing-ethereum-transactions

여유가 되신다면 단일 트랜잭션 뿐만 아니라 트랜잭션의 묶음으로 **생성되는 Block**에도 어떤 정보들이 포함되어 있는지 학습해보셔도 좋을 것 같습니다.

> 학습 후 간단히라도 이해한 바를 정리해서 블로그에 올려 주시고 링크를 공유해 주시기 바랍니다. (네이버 블로그, 티스토리, ..)

---

### **두 번째 과제:** 번호 저장 컨트랙트 작성

이번 주 과제는 총 3개의 컨트랙트를 작성하고 배포하는 것입니다.

1.  `IDStorage` 컨트랙트 배포

컨트랙트 기능: 이름과 번호(6자리 숫자)를 연관지어 저장하고 조회 (방식 자유)

1. `StorageFactory` 컨트랙트 배포

`IDStorage`를 new 키워드를 사용하어 인스턴스화하여 배포. 해당 컨트랙트를 통해 이름과 번호를 저장하는 트랜잭션 남기기

1. `StudentIDStorage` 컨트랙트 배포

`IDStorage`를 상속받은 컨트랙트.

6자리 번호 앞에 “2025”이라는 숫자를 추가하는 함수 작성 후 해당 함수를 실행하는 트랜잭션 남기기

Remix IDE에서 제공하는 VM에서 의도한 대로 작동하는지 여부를 확인하신 후에 1주차 시간에 보여드린 것처럼 sepolia testnetwork로 바꾸신 후 배포해 주시면 됩니다.

이번 과제의 핵심은 상속과 인스턴스화 개념을 익히는 것입니다. 복잡한 코드가 절대 아니니 부담가지지 말고 위 두 개념 이해에 먼저 집중하신다면 쉽게 하실 수 있으리라 판단됩니다.

> **제출물** : 배포한 총 3개의 컨트랙트 주소 (0x로 시작)

---

공유해드린 링크들 중 https://updraft.cyfrin.io/의 강좌 영상들이 몇 개 있습니다.
상속과 인스턴스화 내용을 포함해서 아주 좋은 퀄리티의 강좌들을 회원가입만 하면 무료로 시청할 수 있으니, 로그인 후 자유롭게
둘러보시며 학습하시면 좋을 것 같습니다.

[추천 강좌 : Beginner - **Blockchain Basics , Solidity Smart Contract Development** ]

[Blockchain and Smart Contract Development Courses - Cyfrin Updraft](https://updraft.cyfrin.io/)

영어가 불편하시다면, 한국어 강좌 영상으로는 유투브의 “**솔리디티 깨부수기**” 영상이 있습니다.
짧은 영상 길이와 핵심 정보들만 효율적으로 강의하는 영상이라 Cyfrin의 영어 강좌가 부담스럽다면 강력하게 추천드리는 강좌입니다.

[Solidity 솔리디티 강좌 1강 - Hello Solidity](https://www.youtube.com/watch?v=QYeBPgqKgIc&list=PLJQKWHLhBrxI43w0DU4uQrhWv4Pm1OFlx&ab_channel=D_One)

---

지난 주와 마찬가지로 효과적인 학습을 위해 리서치와 개발 과제가 하나씩 주어졌습니다.

그럼 이번 주도 화이팅입니다🤠!
