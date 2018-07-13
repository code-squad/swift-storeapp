# 스위프트 쇼핑앱

## 요구사항

## 6. 병렬처리 

#### 요구사항

- [쇼팽앱 네트워크 프로그래밍](https://nextstep.camp/courses/-Kv6PmBDDnfeJOzqThWG/-Kv6VFlxhUm2sqJmkFNF/lessons/-L2TQngTWJge_ilnO1T-) 요구사항을 구현한 상태에서 시작한다.
- GCD(Grand Central Dispatch)에 대해 학습하고 정리한다. [강의 자료](http://public.codesquad.kr/jk/storeapp-concurrent-programming-slide.pdf)
- 이미지 다운로드와 캐시 처리 방식에 대해 학습한다.
- readme.md 파일을 자신의 프로젝트에 대한 설명으로 변경한다.
  - 단계별로 미션을 해결하고 리뷰를 받고나면 readme.md 파일에 주요 작업 내용(바뀐 화면 이미지, 핵심 기능 설명)과 완성 날짜시간을 기록한다.
  - 실행한 화면을 캡처해서 readme.md 파일에 포함한다.

#### 프로그래밍 요구사항

- 3개의 JSON 데이터가 모두 받고 나면 JSON 데이터에 포함된 이미지 URL을 분리해서 Image 파일들을 다운로드 받는다.
  - 이미지 파일들을 병렬처리해서 한꺼번에 여러개를 다운로드하도록 구성한다.
  - (선택1) GCD Queue를 활용하거나
  - (선택2) `Download Task` 방식으로 구현한다.
- 다운로드가 완료되면 앱 디렉토리 중에 `Cache` 디렉토리에 URL에 있는 파일명으로 저장한다.
- 셀을 표기할 때 이미 다운로드된 이미지가 있으면 표시하고, 새로운 파일이 다운로드 완료되면 해당 이미지를 테이블뷰 셀에 뒤늦게(lazy) 표시한다.
  - 화면에 표시할 때 다운로드를 담당하는 스레드와 화면을 처리하는 스레드를 위한 GCD Queue를 구분해서 처리한다.
  - 이미지를 다 받을때 까지 화면이 하얗게 멈춰있지 않도록 만든다.

## 작업 이력

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