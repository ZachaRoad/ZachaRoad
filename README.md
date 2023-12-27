# 카카오 모빌리티: 네모톤 - 자차로드
![1 (1)](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/caec5ba2-715f-49ec-b7db-5612d7ae57e1)

## 📖 목차
- [🚘 프로젝트 소개](#-프로젝트-소개)
- [📱 스크린샷](#-스크린샷)
- [💡 주요기능](#-주요-기능)
- [💻 개발 도구 및 활용한 기술](#-개발-도구-및-활용한-기술)

---

## 🚘 프로젝트 소개

2023 네모톤 본선 진출 작품입니다.
네비게이션과 연동하여 업무용 직원 차량 이용 관리, 업무용 운전기록 전산화 관리를 자동화해주는 앱입니다.

<br />

---
## 📱 스크린샷
|앱 진입 화면|차량 등록 실패|위치 정보 동의|
|:----:|:----:|:----:|
|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/7de18b47-abba-4a04-9e32-7c954b322232)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/4261c3f6-455a-4515-8d91-09d4c6b226be)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/4d4cf677-99dc-493f-ada8-d0d9003d94e4)|

|홈 화면|목적지 검색|경로탐색|
|:----:|:----:|:----:|
|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/0b2895d1-c073-4f65-a1b1-a367f9e2640e)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/d00759e4-488a-440d-86af-6399451d965e)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/acd68d5b-46f6-4c64-a26f-017b6cc126c6)|

|네비게이션|월별 운행내역|운행정보|
|:----:|:----:|:----:|
|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/c52ce4c0-fe57-4bb1-9260-fd997c27246a)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/aff8f05e-1a00-4284-b152-92f4ecde6151)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/386b9de9-887c-4290-a15a-beda87d02d1a)|

|지출내역 수정|운행일지 관리|운행일지 전송(이메일)|
|:--------:|:-------:|:--------------:|
|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/f1ff4185-d1ee-4c25-a44d-ee89bdff92d1)|![image](https://github.com/ZachaRoad/ZachaRoad/assets/101093592/0d52320d-8eeb-4de3-bc38-686f0afdbed9)|<img src = "https://github.com/ZachaRoad/ZachaRoad/assets/101093592/2d1efbf4-4112-476e-908e-672dbd98aa52" width = 300>|

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

