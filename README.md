스위프트 쇼핑앱

## 요구사항

## 8. 연결성 확인 Reachability 

#### 요구사항

- [쇼팽앱 상세화면 전환 요구사항](https://nextstep.camp/courses/-Kv6PmBDDnfeJOzqThWG/-Kv6VFlxhUm2sqJmkFNF/lessons/-L2TQwlsRrwEoP0DjTQf)을 구현한 상태에서 시작한다.
- 모빌리티(이동성) 특성과 비용을 줄일 수 있는 방법을 학습하고 적용한다. [강의자료](http://public.codesquad.kr/jk/storeapp-mobility-slide.pdf)
- readme.md 파일을 자신의 프로젝트에 대한 설명으로 변경한다.
  - 단계별로 미션을 해결하고 리뷰를 받고나면 readme.md 파일에 주요 작업 내용(바뀐 화면 이미지, 핵심 기능 설명)과 완성 날짜시간을 기록한다.
  - 실행한 화면을 캡처해서 readme.md 파일에 포함한다.

#### 프로그래밍 요구사항

- ~~애플 Reachability 샘플 클래스로 인터넷 연결 여부를 판단한다.~~
- ~~Reachability.m 또는 Alamofire를 프로젝트에 추가한다.~~
- ~~앱 시작할 때 인터넷 연결이 안되어 있으면, JSON 데이터 파일로 첫 화면을 로딩한다.~~
  - 그 이후 앱이 서버에 연결 가능하면 네트워크 모델을 통해서 JSON 데이터를 받아서 화면을 갱신한다.
- ~~앱 실행중에 연결성이 바뀌는 경우 노티를 받아서~~
  - ~~연결이 안되어 있는 경우 화면의 가장자리(border)를 UIColor.red 로 표시한다.~~
  - ~~연결된 경우 border를 UIColor.green 으로 표시한다.~~

## 작업 이력

### 8. 연결성 확인 Reachability

#### 주요 작업 내역

- Alamofire를 통한 네트워크 연결 상태 확인
- 네트워크 연결이 안 되 있을 경우 로컬의 json을 화면에 노출
- 네트워크 연결이 되어 있는 경우 화면의 `border`를 `.green`로, 안 되어 있는 경우 `.red`로 표시

#### 날짜

- 2018-07-14 13:25

#### 스크린샷

##### 네트워크 연결중

| 메인화면                         | 상세화면                         |
| -------------------------------- | -------------------------------- |
| ![img1](resource/lab8/IMG_1.PNG) | ![img1](resource/lab8/IMG_2.PNG) |

##### 네트워크 미연결

| 세부화면                         | 메인화면                         | 앱을 지웠다 깔 경우              |
| -------------------------------- | -------------------------------- | -------------------------------- |
| ![img1](resource/lab8/IMG_3.PNG) | ![img1](resource/lab8/IMG_4.PNG) | ![img1](resource/lab8/IMG_5.PNG) |

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