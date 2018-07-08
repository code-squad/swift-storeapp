# 스위프트 쇼핑앱

## 요구사항

## 4. 패키지 관리 - CocoaPod 

#### 요구사항

- 쇼팽앱 시작하기 요구사항을 구현한 상태에서 시작한다.
- 오토레이아웃 방식에 대해 학습하고 여러 종류 아이폰 화면에서 모두 보이도록 대응하는 UI를 완성하는 것을 목표로 한다.
  - readme.md 파일을 자신의 프로젝트에 대한 설명으로 변경한다.
  - 단계별로 미션을 해결하고 리뷰를 받고나면 readme.md 파일에 주요 작업 내용(바뀐 화면 이미지, 핵심 기능 설명)과 완성 날짜시간을 기록한다.
  - 실행한 화면을 캡처해서 readme.md 파일에 포함한다.

#### 프로그래밍 요구사항

- Cocoapod 를 설치한다. [설치 가이드](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- `https://github.com/devxoul/Toaster` 저장소에 있는 Toaster 패키지를 cocoapod 으로 설치한다.
- pod으로 설치한 Toaster 모듈을 import 하고 테이블뷰 셀을 터치하면 (didSelect) 타이틀 메뉴와 (할인된)최종 가격 정보를 toast 형태로 표시한다.

## 작업 이력

### 4. 패키지 관리 - CocoaPod

#### 주요 작업 내역

- Pod을 이용한 Toast 라이브러리 사용
- 셀을 누를시 토글로 정보(타이틀, 할인된 가격) 표시

#### 날짜

- 2018-07-08 15:53

#### 스크린샷

<img src="resource/lab4/IMG_9335.PNG?raw=true" width="240"/>

### 3. Custom Section 헤더 적용

#### 주요 작업 내역

- 로컬에있는 3개의  json 파일을 각각 불러와 섹션별로 출력
- 커스텀 섹션 헤더 적용

#### 날짜

- 2018-07-08 15:22

#### 스크린샷

|                      섹션1                       |                      섹션2                       |                      섹션3                       |
| :----------------------------------------------: | :----------------------------------------------: | :----------------------------------------------: |
| ![section1](resource/lab3/IMG_9332.PNG?raw=true) | ![section1](resource/lab3/IMG_9333.PNG?raw=true) | ![section1](resource/lab3/IMG_9334.PNG?raw=true) |



### 2. 오토레이아웃

#### 주요 작업 내역

- 상단 Section Header에 오토레이아웃 적용
- 위 요구사항대로 Cell에 오토레이아웃 적용

#### 날짜

- 2018-07-08 13:44

#### 스크린샷

각 디바이스별 스크린샷은 [resource/iphone-big](resource/iphone-big), [resource/iphone-small](resource/iphone-small)에 저장되어 있습니다.

![Screen Shot 2018-07-08 at 1.42.31 PM](resource/iphone-big/Screen%20Shot%202018-07-08%20at%201.42.31%20PM.png?raw=true)

![Screen Shot 2018-07-08 at 1.42.31 PM](resource/iphone-small/Screen%20Shot%202018-07-08%20at%201.38.42%20PM.png?raw=true)

### 1. 상품 목록

#### 주요 작업 내역

- 로컬에있는 json  파일 불러와 TableView에 출력
- 상단의 섹션헤더 추가 
- Cell 내부에 동적으로 태그 Label 출력

#### 날짜

- 2018-07-08 12:52

#### 스크린샷

<img src="resource/image-20180708130520715.png" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="340"/>