안녕하세요!

4주차는 **컨트랙트 개발에 가장 널리 사용되는 프레임워크 중 하나인 Foundry**를 배워보는 시간입니다.

실제 개발자들이 사용하는 Foundry를 직접 다뤄보면서 Remix IDE에서 벗어나 본격적인 로컬 개발 환경을 구성하는 데 목표를 둡니다.

---

## **첫 번째 과제:** Foundry 개발 환경 익숙해지기

Foundry는 빠르고 깔끔한 스마트 컨트랙트 개발 도구입니다. Hardhat보다 더 빠르고 Rust 기반 CLI를 통해 보다 정교한 컨트롤이 가능합니다.

이번 과제에서는 Foundry 환경을 로컬에 구축하고, 지난주에 작성한 ERC20 토큰 컨트랙트를 컴파일, 배포, 테스트해보는 것이 되겠습니다.

### [학습 자료]

- [Foundry 공식 문서 자료](https://book.getfoundry.sh/)
- [Foundry 영어 강좌](https://updraft.cyfrin.io/courses/foundry)
- [멍개의연구소 - 한국어 강좌](https://www.youtube.com/watch?v=9LDkEugcFS8&ab_channel=%EB%A9%8D%EA%B0%9C%EC%9D%98%EC%97%B0%EA%B5%AC%EC%86%8C)

<aside>
✍🏼

다 보실 필요 없습니다. 기본 학습 후에 과제를 진행하면서 이해되지 않는 부분만 찾아서 시청하시는 걸 권장드립니다.

</aside>

### [과제 내용]

Foundry를 사용하기 위해선 **WSL2(Windows Subsystem for Linux)**를 설치해야 합니다.

[설치 방법 가이드](https://blog.naver.com/dalbichi9802/223863685747)

위 블로그 가이드를 따라하시면 됩니다. 아래 공식 가이드도 첨부하였습니다.

[WSL 설치 문서 가이드](https://learn.microsoft.com/ko-kr/windows/wsl/install)

> **제출물**: WSL과 Foundry에 대한 본인의 이해를 간단히 정리한 블로그 포스트 (티스토리, 노션, 네이버 블로그 등)
> _작성 후 저에게 링크를 공유해 주세요!_

---

## **두 번째 과제:** ERC20 컨트랙트를 Foundry으로 마이그레이션하기

이전 주차에 작성했던 **ERC20 토큰 컨트랙트**를 Foundry 기반으로 다시 작성하고, 배포 및 테스트 코드까지 구현해보는 것이 주 과제입니다.

> 깃허브 레퍼지토리 링크 ⇒ https://github.com/Imjungjuna/blockchainStudy_2025-1/blob/main/week-3/code/custom_erc20.sol

동일한 코드를 가져가는 이유는 지난 주 과제 내용을 복습하면서 Foundry 사용법에 집중할 수 있도록 하기 위함입니다.

### [과제 내용]

1. 지난주 Remix에서 만든 ERC20 토큰 컨트랙트를 foundry에 옮기기
2. foundry를 이용하여 배포
3. 테스트 스크립트를 생성하여 **다음 항목 테스트**
   1. 초기 발행량이 배포자에게 할당되었는가?
   2. 토큰 전송 기능(`transfer`)이 정상 작동하는가?
   3. `mint()`는 오직 배포자만 호출 가능한가?
   4. `burn()`은 본인 계정에서만 가능한가?
   5. `approve()`와 `transferFrom()` 기능이 잘 작동하는가?

> 제출물: 완성된 코드 깃허브에 업로드, 스터디 시간에 확인
