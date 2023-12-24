# 카카오 모빌리티: 네모톤 - 자차로드
<img src = "https://github.com/Changhyun-Kyle/ZachaRoad/assets/101093592/5d6ad479-dd5d-4e46-901f-1326d546547a">

## 📖 목차
- [🚘 프로젝트 소개](#-프로젝트-소개)
- [📱 스크린샷](#-스크린샷)
- [💡 주요기능](#-주요-기능)
- [💻 개발 도구 및 활용한 기술](#-개발-도구-및-활용한-기술)

---

## 🚘 프로젝트 소개

네비게이션과 연동하여 업무용 직원 차량 이용 관리, 업무용 운전기록 전산화 관리를 한번에!

<br />

---
## 📱 스크린샷
|앱 진입 화면|차량 등록 실패|위치 정보 동의|
|:----:|:----:|:----:|
|<img src = "https://hackmd.io/_uploads/S1hECVSva.png">|<img src = "https://hackmd.io/_uploads/r15MRESD6.png">|<img src = "https://hackmd.io/_uploads/HybOgHHPT.png">|

|홈 화면|목적지 검색|경로탐색|
|:----:|:----:|:----:|
|<img src = "https://hackmd.io/_uploads/r1aN1rrwT.png">|![[안내화면]simulator_screenshot_83602343-6CE7-4F18-B73B-2F96AB9A9CF1 (1)](https://hackmd.io/_uploads/HJaeeSrP6.png)|![image](https://hackmd.io/_uploads/SJm3dSrw6.png)|

|네비게이션|월별 운행내역|운행정보|
|:----:|:----:|:----:|
|![image](https://hackmd.io/_uploads/ryIYyBSv6.png)|![image](https://hackmd.io/_uploads/Syw9JBHP6.png)|![image](https://hackmd.io/_uploads/SkP3Grrvp.png)

|지출내역 수정|운행일지 관리|운행일지 전송(이메일)|
|:--------:|:-------:|:--------------:|
|![image](https://hackmd.io/_uploads/BJEnySBP6.png)|![image](https://hackmd.io/_uploads/By2XrBHDa.png)|![RPReplay_Final1693535603 2 (1)](https://hackmd.io/_uploads/HJsMHrBP6.gif)|

<br />
---
## 💡 주요 기능
- **`앱 진입화면`** [차량제원API](https://dataapi.co.kr/dLab/mdh_api.do)를 사용해 등록된 차량을 조회하고 이를 기반으로 회원가입을 할 수 있습니다.
- **`홈`** 위치 정보 제공 동의를 받고, 목적지를 검색 및 탭하여 직접 등록할 수 있습니다.
- **`네비게이션`** 위에서 선택한 목적지들로 안내를 시작합니다.
- **`운행내역`** 월별 운행 내역(총 거리, 총 비용)을 확인할 수 있습니다. 개별 운행내역들은 상세 운행정보 페이지로 연결됩니다.
- **`운행정보`** 운행정보를 확인하고, 기입되지 않은 정보 및 추가적으로 작성해야하는 정보들을 수정 및 저장할 수 있습니다.
- **`지출내역 수정`** 위 운행 정보 속의 상세 비용에 해당하는 정보들을 수정할 수 있습니다.
- **`운행일지 관리`** 선택한 운행일지를 정해진 양식에 맞게 이메일로 작성합니다. 사용자는 받는 이의 이메일 주소만 입력하면 됩니다.

<br />
---
## 💻 개발 도구 및 활용한 기술
- 개발 언어 : Swift, Objective-C
- 디자인 툴 : Figma
- 협업 도구 : Github, Team Notion, Discord
- 활용한 기술
    - SwiftUI, UIKit
    - FireStore
    - KakaoMapSDK, KNSDK API, Kakao 키워드로 장소검색 API, Dataapi(차량제원)
    - Alamofire

