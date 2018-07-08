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

- ~~다음 2개 파일을 다운로드해서 프로젝트에 복사하고 JSONDecoder를 활용해서 모델 객체를 기존 main과 함께 섹션(section)을 구분할 수 있도록 개선한다.~~
  - soup.json 데이터 경로 => `http://public.codesquad.kr/jk/storeapp/soup.json`
  - side.json 데이터 경로 => `http://public.codesquad.kr/jk/storeapp/side.json`
- ~~스토리보드 ViewController에 Cell에 Section Header로 사용할 Custom Cell을 추가한다.~~
  - 총 섹션은 3개로 구분해서 헤더에 다음과 같이 표시한다.
  - main => `메인반찬 / 한그릇 뚝딱 메인 요리`
  - soup => `국.찌게 / 김이 모락모락 국.찌게`
  - side => `밑반찬 / 언제 먹어도 든든한 밑반찬`

#### 목표 실행 화면

![img](http://public.codesquad.kr/jk/storeapp-tableview.png)

## 작업 이력

### 4. 패키지 관리 - CocoaPod

#### 주요 작업 내역

- 

#### 날짜

- 

#### 스크린샷



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