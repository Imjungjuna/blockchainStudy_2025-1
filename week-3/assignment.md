안녕하세요!

3주차에는 **ERC20 토큰 및 Solidity 입문(3)**을 다룹니다.
토큰의 표준이 되는 ERC20을 알고 활용하는 것이 이번 주 목표이며, 향후 차익 거래 봇 개발에 필수적인 토큰 간 전송과 밸런스 확인 등 기초를 익히는 한 주가 되겠습니다.

---

## **첫 번째 과제:** ERC20 토큰 관련 개념 학습

ERC20은 이더리움 생태계에서 통용되는 **토큰 표준 인터페이스**입니다. 차익 거래 봇에서 이 토큰들을 읽고, 비교하고, 전송하는 작업이 많기 때문에 확실히 개념을 잡아야 합니다.

### **ERC20 개념 파악하기**

https://www.youtube.com/watch?v=cqZhNzZoMh8&ab_channel=SimplyExplained

https://www.youtube.com/watch?v=acYcOs7HOls&ab_channel=MoralisforDevelopers

간단히 위의 두 동영상을 보고 ERC20에 관한 개념을 습득하시기 바랍니다.

https://www.youtube.com/watch?v=T5MGfOMcdIk&ab_channel=%EC%BD%94%EB%B9%97Korbit

https://brunch.co.kr/@gapcha/162

영어가 불편하시다면 아래 두 링크를 참고하신 후에 시청하시면 도움이 될 것 같습니다.

참고 후 아래 개념을 꼭 이해하고 정리해 주세요.

**필수적으로 학습**해야 하는 개념

- ERC20의 역할 및 이더리움 생태계 내 위치
- `balanceOf`, `transfer`, `approve`, `transferFrom`, `allowance` 함수의 역할
- 이벤트(Event)의 사용 예시 (특히 **Transfer**, **Approval**)
- 스마트 컨트랙트 간 ERC20 상호작용 개요

> **제출물**: 본인의 이해를 간단히 정리한 블로그 포스트 (티스토리, 노션, 네이버 블로그 등)
> _작성 후 링크를 공유해 주세요!_

---

## **두 번째 과제:** ERC20 토큰 컨트랙트 작성 및 배포

개념 이해가 되었다면, 그 다음은 직접 컨트랙트를 작성해 봄으로써 "이해하고 조작 가능한" 단계가 되어야 합니다. Remix IDE에서 아래 과제를 수행하시기 바랍니다.

### 실습 과제 내용

1. 아래 조건의 ERC20 토큰 컨트랙트 작성
   - 이름, 심볼, 초기 발행량을 자유롭게 지정
   - `mint` 기능 포함 (단, 오직 deployer만 호출 가능)
   - `burn` 기능 추가 (본인 토큰만 소각 가능)
2. Remix VM에서 정상 작동 확인 후, **Sepolia Testnet**으로 배포
3. Metamask를 통해 실제 배포를 경험하고 가스 사용량 확인

제공하는 VM에서 의도한 대로 작동하는지 여부를 확인하신 후에 지난 시간에 보여드린 것처럼 sepolia testnetwork로 바꾸신 후 배포해 주시면 됩니다.

이번 과제의 핵심은 ERC20 토큰을 다루는 법을 익히는 것입니다. 간단한 코드이니 부담 없이 개념 이해에 집중하신다면 쉽게 하실 수 있으리라 판단됩니다.

> **제출물**: Sepolia에 배포한 **컨트랙트 주소 (0x...)**

---

[추천 강좌 : Beginner - **Blockchain Basics , Solidity Smart Contract Development** ]

[Blockchain and Smart Contract Development Courses - Cyfrin Updraft](https://updraft.cyfrin.io/)

영어가 불편하시다면, 한국어 강좌 영상으로는 유투브의 “**솔리디티 깨부수기**” 영상이 있습니다.
짧은 영상 길이 + 핵심 정보들만 효율적으로 강의

[Solidity 솔리디티 강좌 1강 - Hello Solidity](https://www.youtube.com/watch?v=QYeBPgqKgIc&list=PLJQKWHLhBrxI43w0DU4uQrhWv4Pm1OFlx&ab_channel=D_One)

---

지난 주와 마찬가지로 효과적인 학습을 위해 리서치와 개발 과제가 하나씩 주어졌습니다.

시험 기간을 고려해 부담은 줄이고, 꼭 필요한 핵심 개념을 담았으니 집중해서 공부해 주세요!
이번 주까지 진행하고 중간고사 기간에는 휴식 주간을 가질 예정입니다.

이번 주도 화이팅입니다✌!

---

### 참고) 이걸 학습하는 이유?

향후 우리가 만들게 될 **차익 거래 봇**은 아래 과정을 반복합니다:

1. 여러 DEX(탈중앙 거래소)에서 토큰 가격 비교
2. 차이가 발생하면 A 거래소에서 토큰 구매, B 거래소에서 토큰 판매
3. ERC20 토큰을 전송하거나, 잔액을 확인하고, 권한을 위임하는 작업

이번 주에 공부하게 될 `balanceOf`, `transfer`, `approve`, `transferFrom` 같은 함수는 이 모든 과정을 자동화하는 \*\*\*\*로직의 핵심 구성 요소입니다.

그러니 이번 과제는 그러한 자동화를 가능하게 만드는 "기본기 다지기"라고 생각하시면 됩니다. 단순한 코드 같아도 이 함수들을 얼마나 정확히 이해하고 활용하느냐가 **자동화 속도, 거래 성공률, 가스 효율성** 등을 좌우하게 됩니다.

이번 주 과제를 통해 여러분이 만든 토큰을 수수료 수익을 위해 유동성 풀에 넣어볼 수도, NFT 프로젝트의 결제 수단으로 활용할 수도, 에어드롭 이벤트를 여는 데에 사용할 수도 있습니다.
블록체인의 세계는 무궁무진합니다. 조금 버겁게 느껴질 때가 있더라도 끝까지 따라와 주시면 유익하고 재미있는 경험이 될 것이라고 생각합니다.
