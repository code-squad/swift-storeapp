스위프트 쇼핑앱

## 요구사항

## 7. 상품 상세화면 전환 

#### 요구사항

- [쇼팽앱 병렬처리](https://nextstep.camp/courses/-Kv6PmBDDnfeJOzqThWG/-Kv6VFlxhUm2sqJmkFNF/lessons/-L2TQuK0yjABnlLpcgjR) 요구사항을 구현한 상태에서 시작한다.
- 상품 상세 화면을 만들고, 주문 동작을 구현한다.
- HTTP POST 요청 방식에 대해 학습하고 응용 방식을 구현한다.
- readme.md 파일을 자신의 프로젝트에 대한 설명으로 변경한다.
  - 단계별로 미션을 해결하고 리뷰를 받고나면 readme.md 파일에 주요 작업 내용(바뀐 화면 이미지, 핵심 기능 설명)과 완성 날짜시간을 기록한다.
  - 실행한 화면을 캡처해서 readme.md 파일에 포함한다.

#### 프로그래밍 요구사항

- ~~ViewController 를 Navigation Controller로 embed 하세요.~~
- ~~cell을 선택하면 상품 상세 화면을 보이도록 새로운 뷰 컨트롤러를 만드세요.~~
- ~~상세 화면 디자인은 다음 슬라이드를 참고하세요.~~<br>![img](http://public.codesquad.kr/jk/storeapp-step7-view.png)
  

- ~~상세 화면(DetailViewController)으로 선택한 cell의 `detail_hash` 값을 전달하세요.~~
- ~~상세 화면에 대한 Delegate 프로토콜과 프로토콜을 채택하는 속성을 추가하세요.~~
  - ~~상세 화면에서 결과를 전달하기 위한 Delegate 프로토콜을 선언하세요.~~
  - ~~프로토콜에는 주문을 완료했을 때 호출할 메소드를 선언하세요.~~
  - ~~ViewController에는 프로토콜을 채택하고 위의 메소드를 구현하세요.~~
- ~~`http://crong.codesquad.kr:8080/woowa/detail/{detail_hash}` URL 형식으로 요청하고 받은 JSON 데이터를 Decode 하는 네트워크 담당 모델 객체를 만드세요.~~
  - ~~URL 예시 `http://crong.codesquad.kr:8080/woowa/detail/H9881` 또는 `http://crong.codesquad.kr:8080/woowa/detail/HDF4C`~~
- ~~상세 화면을 표시하기 전에 네트워크 담당 모델 객체에서 데이터를 받아서 화면 정보를 채워서 표시하세요.~~
  - ~~self.view 커스텀 클래스를 UIScrollView로 지정하고 하위 뷰들은 self.view.contentView 에 추가하세요.~~<br>☞ StackView 사용
  - ~~ScrollView ContentSize에 대해 찾아보고, 전체 콘텐츠 높이를 계산해서 스크롤되도록 값을 지정하세요.~~ <br>☞ StackView 사용
  - ~~상단 ScrollView 에 thumb_images 항목의 이미지들을 Page 형태로 추가하세요. 좌우로 페이지 넘기듯이 넘어가도록 만드세요.~~
  - ~~설명 아래부분에는 제품 상세 설명을 위해서 detail_section 항목의 이미지들을 코드로 이어서 붙이세요.~~
- ~~[주문하기] 버튼을 누르면 델리게이트 객체에 주문 완료 메소드를 호출합니다.~~
  - ~~프로토콜 채택한 객체는 슬랙으로 “누가-얼마짜리-메뉴” 주문을 POST 요청으로 보내는 기능을 네트워크 모델에 추가하세요.~~
  - ~~주문을 완료하고 나면 창을 닫고 이전 화면으로 돌아가도록 작성하세요.~~
  - ~~슬랙 incoming hook URL `https://hooks.slack.com/services/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`~~

## 작업 이력

### 7. 상품 상세화면 전환

#### 주요 작업 내역

- 상세화면
- 상세화면의 POST 방식 주문 기능
- UIStackView + UIScrollView를 활용한 세로 스크롤
- UIScrollView의 페이징과 UIPageControl을 활용한 가로 페이징 스크롤
- 화면의 이미지 개별 다운

#### 날짜

- 2018-07-13 20:02

#### 스크린샷

| 세부화면                         | 결제 완료 후 화면                |
| -------------------------------- | -------------------------------- |
| ![img1](resource/lab7/IMG_1.PNG) | ![img1](resource/lab7/IMG_2.PNG) |



### 6. 병렬처리

#### 주요 작업 내역

- Model-View-ViewController 파일 분리
- Delegate(TableViewDelegate & TableViewDataSource) 코드 분리
- 각 개별 이미지를 병렬 다운로드
- 개별 이미지 다운로드 후 NSCache에 저장
- 이미지 다시 호출시 캐시 확인 후 없으면 다운로드
- 이미지 다운로드시 `URLSession.shared.dataTask ` 로 비동기 처리 후 다운로드 완료시 `DispatchQueue.main.async ` 로 메인큐에서 셀 갱신(셀 재사용을 고려한 조건문)

#### 날짜

- 2018-07-13 10:43

#### 스크린샷

| 개별 이미지 로딩 전                 | 개별 이미지 로딩 후                 |
| ----------------------------------- | ----------------------------------- |
| ![img1](resource/lab6/IMG_9375.PNG) | ![img1](resource/lab6/IMG_9376.PNG) |



### 5. Network 프로그래밍 

#### 주요 작업 내역

- URLSession를 활용한 HTTP요청
- Section별로 다른 Session을 만들어 HTTP요청 후, 각각의 응답에따른 각각의 화면 갱신
- 몇 코드 정리

#### 날짜

- 2018-07-09 21:23

#### 스크린샷

| 네트워크 통신 전                    | 네트워크 통신 후                    |
| ----------------------------------- | ----------------------------------- |
| ![img1](resource/lab5/IMG_9340.PNG) | ![img2](resource/lab5/IMG_9341.PNG) |

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

<img src="resource/lab1/img1.PNG" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="340"/>