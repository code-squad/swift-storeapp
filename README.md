# - Step1 (상품 목록)

## 요구사항
- 스토리보드 ViewController에 TableView를 추가하고 Safe 영역에 가득 채우도록 frame을 설정한다.
- 테이블뷰에 새로운 프로토타입 Cell을 추가하고, Custom 스타일로 지정하고 다음과 같이 디자인한다.
- main.json 데이터 경로 => http://public.codesquad.kr/jk/storeapp/main.json
- 위 파일을 다운로드해서 프로젝트에 복사하고 JSONDecoder를 활용해서 내부에 Array<StoreItem> 타입으로 변환하는 DataSource에서 사용할 모델 객체를 만든다.
	- subscript로 배열에 index로 접근하면 StoreItem 구조체를 반환한다.
	- StoreItem은 Decodable 프로토콜을 채택하고, main.json에 있는 키와 값을 매핑해서 속성으로 갖도록 구현한다.
- UITableViewDataSource 프로토콜 구현 부분에서 cell을 위에서 만든 DataSource 모델 객체에 접근해서 테이블뷰를 표시한다.

## 실행화면
![screemsh_step1](./img/Step1.png)

# - Step2 ( AutoLayout 적용 )

## 요구사항
- 스토리보드 ViewController에 Cell을 Content View를 기준으로 하위 뷰들에 오토레이아웃을 적용한다.
	- 메뉴 이미지 뷰는 top, bottom, lead 제약을 주고 width 제약을 넣는다. height와 width 비율은 1:1로 aspectRatio를 맞춘다.
	- 타이틀 제목은 메뉴 이미지보다 10pt 우측에 lead 제약을 주고, top, tail 제약을 주고, height 제약을 준다.
	- 상세 설명도 top 제약만 타이틀 제목보다 4pt 띄우고, 나머지는 타이틀에 맞춘다.
	- 메뉴 가격도 width 제약을 넣고, 나머지는 타이틀과 마찬가지로 제약을 준다.
	- 이벤트 배지는 최소width 제약만 주고 글자 내용에 맞추고, 없을 경우 감춘다.

## 실행화면
![screemsh_step2](./img/Step2.png)

## AutoLayout
-  

## Priority & isActive
 - 우선순위, Priority는 UILayoutPriority로 설정할 수 있으며 1에서 1000까지의 값을 갖는다.
 - Required는 1000, DefaultHigh는 750, DefaultLow는 250의 기본값을 갖는다.
  	- 세 가지 우선순위로 제약조건이 걸려있는 경우 1000이 가장 높은 영향력을 가지며, 1000이 없어진 경우 750, 750이 없어진 경우 250, 순차적으로 연결된다.
 - Constraint의 isActive를 true/false로 변경하면 해당 값을 활성화/비활성화할 수 있다. 단, 이때 해당 Constraint가 weak으로 연결되면 ARC 문제로 해제될 경우가 있으므로 Strong으로 연결해야 한다.

# - Step3 ( Custom Section 헤더 적용 )
## 요구사항
- 다음 2개 파일을 다운로드해서 프로젝트에 복사하고 JSONDecoder를 활용해서 모델 객체를 기존 main과 함께 섹션(section)을 구분할 수 있도록 개선한다.
	- soup.json 데이터 경로 => http://public.codesquad.kr/jk/storeapp/soup.json
	- side.json 데이터 경로 => http://public.codesquad.kr/jk/storeapp/side.json

- 스토리보드 ViewController에 Cell에 Section Header로 사용할 Custom Cell을 추가한다.
	- 총 섹션은 3개로 구분해서 헤더에 다음과 같이 표시한다.
	- main => 메인반찬 / 한그릇 뚝딱 메인 요리
	- soup => 국.찌게 / 김이 모락모락 국.찌게
	- side => 밑반찬 / 언제 먹어도 든든한 밑반찬

## 실행화면
![screemsh_step3](./img/Step3.png)

# - Step4 ( Cocoapods )
## 요구사항
- Cocoapod 를 설치한다.
	- https://github.com/devxoul/Toaster 저장소에 있는 Toaster 패키지를 cocoapod 으로 설치한다.
	- pod으로 설치한 Toaster 모듈을 import 하고 테이블뷰 셀을 터치하면 (didSelect) 타이틀 메뉴와 (할인된)최종 가격 정보를 toast 형태로 표시한다.

## 실행화면
![screemsh_step4-1](./img/Step4-1.png)
![screemsh_step4-2](./img/Step4-2.png)


## 학습꺼리
- 다른 패키지 매니저 도구가 어떤게 있는지 학습하고 비교해서 정리한다.
(https://medium.com/xcblog/carthage-or-cocoapods-that-is-the-question-1074edaafbcb)

	- CocoaPods
		- 장점 : 설치 및 사용이 쉽고, 커뮤니티가 크고 활발하다.(대부분의 오픈소스가 포함되어있음)
		- 단점 : 프로젝트 내용 및 파일을 자동으로 알지 못하는 방향으로 수정하는 경우가 있다.

	- Carthage
		- 장점 : 프로젝트를 건들지 않아 정확한 컨트롤이 가능하다.
	  - 단점 : 느리고, 커뮤니티가 크지 않다.

	- Swift Package Manager
		- 장점 : Apple에서 공식 지원한다.
		- 단점 : 초창기, 표준 Swift Package의 Directory 구조를 따라야 한다.


- 프로젝트 설정과 관련된 용어에 대해 학습하고 정리한다.(https://stackoverflow.com/questions/20637435/xcode-what-is-a-target-and-scheme-in-plain-language/20637892#20637892)
	- Workspace - Contains one or more projects. These projects usually relate to one another
	- Project - Contains code and resources, etc. (You'll be used to these!)
	- Target - Each project has one or more targets.
		- Each target defines a list of build settings for that project
		- Each target also defines a list of classes, resources, custom scripts etc to include/ use when building.
		- Targets are usually used for different distributions of the same project.
			- For example, my project has two targets, a "normal" build and an "office" build that has extra testing features and may contain several background music tracks and a button to change the track (as it currently does).
			- You'll be used to adding classes and resources to your default target as you add them.
			- You can pick and choose which classes / resources are added to which target.
				- In my example, I have a "DebugHandler" class that is added to my office build
			- If you add tests, this also adds a new target.
	- Scheme - A scheme defines what happens when you press "Build", "Test", "Profile", etc.
		- Usually, each target has at least one scheme
		- You can autocreate schemes for your targets by going to Scheme > Manage Schemes and pressing "Autocreate Schemes Now"

# - Step5 ( Network 프로그래밍 )
## 요구사항
- 아래 주소별로 JSON 데이터를 받아오는 모델 객체를 만든다.
	- HTTP 프로토콜 GET 요청으로 다음 주소에서 메인반찬 JSON 데이터를 받는다. http://crong.codesquad.kr:8080/woowa/main
	- HTTP 프로토콜 GET 요청으로 다음 주소에서 국.찌게 JSON 데이터를 받는다. http://crong.codesquad.kr:8080/woowa/soup
	- HTTP 프로토콜 GET 요청으로 다음 주소에서 밑반찬 JSON 데이터를 받는다. http://crong.codesquad.kr:8080/woowa/side
- HTTP 요청은 URLSession 관련 프레임워크를 활용한다.
- 응답으로 받은 JSON 데이터를 마찬가지 방법으로 Decode해서 StoreItem 객체로 변환한다.
- 모델 객체는 응답이 도착하면 Notification을 보내서 테이블뷰의 해당 섹션만 업데이트한다.

## 학습꺼리
### 1. 네트워크의 역사
  - 네트워크란? 정보를 옮기는 것.
  - 예전에는 전화국이 있었음. (Telephone excahange -> Bule-box 등등)
  - IETF라는 기관이 생김. 네트워크 관련 약자들을 다 표준화 시킴.

### 2. iOS Networking
  - Application 하위로 3개의 API를 사용할 수 있음.
    - Foundation,  CFNetwork, Core OS(Darwin)

  - 고려해야될 사항
    - Packet Problems : 기존 유선의 네트워킹에선 Circuit(하나의 회로)단위였다면, 무선 통신은 Packet단위로 통신되기에 발생되는 문제들.
    - latenct : 응답을 요청하면, 받는데까지 걸린 시간
    - security
    - Service Discovery : 서비스랑 어드레스랑 매칭하는 것들. Ex) DNS - nslookup 주소

  - Core OS(Darwin)
    - Run loop integration : OS에 요청했던 데이터를 주기적으로 계속 물어봐야 된다.

### 3. APIs for HTTP / HTTPs
  - NSURLConnection(iOS 10부터 없어짐) -> NSURLSession
    - Wait for response에 보통 데이터의 길이를 넘겨준다.
  - NSNetService
  - NSURLStream

### 4. NSURLSession
  - 4가지 종류가 있음.
    1. Singleton shared Session : 요청이 끝났을 때, 어떻게 할 건지 클로져로 쓸 수 있게만 하는 것.
    2. Default Session : 설정을 줄 수 있는 세션, 보통 이 세션을 가장 많이 쓴다.
    3. Ephemeral Session : 사파리나 크롬에서 개인정보보호 모드를 사용할 때, 사용.
    4. Background Session : App이 Background를 들어가도 사용할 수 있는 Session (주로 파일 업로드 or 다운로드)

  - Session의 Task들 (주로 dataTask를 가장 많이 쓴다.)
    - completionHandler안에서 response가 없으면 error가 있고, error가 없으면, response가 있다.

### ALAMOFIRE
  -  Chainable Request / Response Methods
  - URL / JSON / plist Parameter Encoding
  - Upload File / Data / Stream / MultipartFormData
  - Download File using Request or Resume Data
  - Authentication with URLCredential
  - HTTP Response Validation
  - Upload and Download Progress Closures with Progress
  - cURL Command Output
  - Dynamically Adapt and Retry Requests
  - TLS Certificate and Public Key Pinning
  - Network Reachability
  - Comprehensive Unit and Integration Test Coverage

# - Step6 ( 병렬처리 )
## 요구사항
- 3개의 JSON 데이터가 모두 받고 나면 JSON 데이터에 포함된 이미지 URL을 분리해서 Image 파일들을 다운로드 받는다.
	- 이미지 파일들을 병렬처리해서 한꺼번에 여러개를 다운로드하도록 구성한다.
	- (선택1) GCD Queue를 활용하거나
	- (선택2)Download Task 방식으로 구현한다.
- 다운로드가 완료되면 앱 디렉토리 중에 Cache 디렉토리에 URL에 있는 파일명으로 저장한다.
- 셀을 표기할 때 이미 다운로드된 이미지가 있으면 표시하고, 새로운 파일이 다운로드 완료되면 해당 이미지를 테이블뷰 셀에 뒤늦게(lazy) 표시한다.
	- 화면에 표시할 때 다운로드를 담당하는 스레드와 화면을 처리하는 스레드를 위한 GCD Queue를 구분해서 처리한다.
	- 이미지를 다 받을때 까지 화면이 하얗게 멈춰있지 않도록 만든다.

## 실행화면
![screemsh_step6](./img/Step6.png)

# - Step7 ( 상품 상세화면 전환 )
## 요구사항
1. 상품 상세 화면(View) 구현
	- ViewController 를 Navigation Controller로 embed
	- cell을 선택하면 상품 상세 화면을 보이도록 새로운 뷰 컨트롤러를 구현
	- 상세 화면 디자인은 NextStep 참고

2. 상세화면 VC - View 연결 및
	- 상세 화면(DetailViewController)으로 선택한 cell의 detail_hash 값을 전달하세요.
	- http://crong.codesquad.kr:8080/woowa/detail/{detail_hash} URL 형식으로 요청하고 받은 JSON 데이터를 Decode 하는 네트워크 담당 모델 객체를 만드세요.
	  - URL 예시 http://crong.codesquad.kr:8080/woowa/detail/H9881 또는 http://crong.codesquad.kr:8080/woowa/detail/HDF4C
	- 상세 화면을 표시하기 전에 네트워크 담당 모델 객체에서 데이터를 받아서 화면 정보를 채워서 표시하세요.
	  - self.view 커스텀 클래스를 UIScrollView로 지정하고 하위 뷰들은 self.view.contentView 에 추가하세요.
	  - ScrollView ContentSize에 대해 찾아보고, 전체 콘텐츠 높이를 계산해서 스크롤되도록 값을 지정하세요.
	  - 상단 ScrollView 에 thumb_images 항목의 이미지들을 Page 형태로 추가하세요. 좌우로 페이지 넘기듯이 넘어가도록 만드세요.
	  - 설명 아래부분에는 제품 상세 설명을 위해서 detail_section 항목의 이미지들을 코드로 이어서 붙이세요.

3. 주문 동작 구현(Network)
	- 상세 화면에 대한 Delegate 프로토콜과 프로토콜을 채택하는 속성을 추가하세요.
	  - 상세 화면에서 결과를 전달하기 위한 Delegate 프로토콜을 선언하세요.
	  - 프로토콜에는 주문을 완료했을 때 호출할 메소드를 선언하세요.
	  - ViewController에는 프로토콜을 채택하고 위의 메소드를 구현하세요.
	- [주문하기] 버튼을 누르면 델리게이트 객체에 주문 완료 메소드를 호출합니다.
	  - 프로토콜 채택한 객체는 슬랙으로 “누가-얼마짜리-메뉴” 주문을 POST 요청으로 보내는 기능을 네트워크 모델에 추가하세요.
	  - 주문을 완료하고 나면 창을 닫고 이전 화면으로 돌아가도록 작성하세요.
	  - 슬랙 incoming hook URL https://hooks.slack.com/services/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

## 학습꺼리
### HTTP
- NSURLSessionTask는 웹 서버와 통신할 때, HTTP 명세에 나온 규칙을 따른다. (이 명세는 클라이언트와 서버 사이의 요청/응답 교환의 포맷에 관해 매우 명확하다.)
	- HTTP요청은 요청 라인, 요청 헤더, 선택적 요청 바디, 세부분으로 나뉜다.
		- 요청 라인: 첫번째 줄로, 서버에 클라이언트가 무엇을 하려고 하는지 알린다.
		- HTTP의 메서드 중 가장 많이 사용되는 것은 GET과 POST로, NSURLRequest의 기본 값은 GET으로 클라이언트가 서버로부터 리소스를 원한다는 것을 나타낸다. 요청된 리소스는 웹 서버상의 파일시스템에 있는 실제 파일이거나, 요청을 받는 시점에 동적으로 생성될 수 있다. 클라이언트에서는 이러한 세부사항에 관해서 관여할 수 없다.
		- 서버로부터 뭔가를 얻는 것 뿐만 아니라, 정보를 보낼 수도 있다. 예를 들어, 많은 웹 서버들이 사진 업로드를 허용한다. 클라이언트 프로그램은 HTTP 요청을 통해, 이미 데이터를 서버에 전달할 것이다. 이러한 상황에 HTTP 메서드 POST를 사용하여, 이 메서드에 요청바디를 포함할 것이다. 요청의 바디는 서버에 전달할 페이로드다. 보통 JSON, XML, 바이너리 데이터 등이다.
	- HTTP 요청 포맷
	![screensh_step7_1](http://www.libqa.com/imageView?path=/resource/real/57/20130626/thumb/thumb_2013062623850833813567817.jpg)
	- HTTP 요청 포맷 예시
	![screenshot_step7_2](http://images.slideplayer.com/31/9769996/slides/slide_5.jpg)
	- HTTP 응답 포맷 예시
	![screenshot_step7_3](http://images.slideplayer.com/26/8484284/slides/slide_2.jpg)
	- slack의 incoming webhook을 이용하려면
		- payload 파라메터를 보낼 때 JSON string으로 보내야 한다.
		- method는 POST로 전송해야 한다.
		- payload의 property 목록
		```
				var payload = {
					// bot 이름을 바꿀 수 있다. "username" : "",
					// bot 아이콘을 바꿀 수 있다. "icon_url" : "",
					// bot 아이콘을 이모티콘으로 사용할 수 있다. 위의 icon_url 중 하나만 사용하면 된다. "icon_emoji" : "",
					// 본문 내용을 입력한다. (필수) "text" : "", // 채널을 override 시킬 수 있다. "channel" : ""
				}
				```
	- 이를 이용한 내 코드
	```
			func order() {
				guard let url = URL(string: Keyword.ItemDetail.order.URL) else { return }
				var request = URLRequest(url: url)
				request.httpMethod = Keyword.httpMethod.name
				let detailInfoString = "\(detailPrice.text ?? "")-\(detailTitle.text ?? "")"
				let detailInfoData = try? JSONSerialization.data(withJSONObject: [Keyword.payLoadText.name : detailInfoString])
				request.httpBody = detailInfoData
				URLSession.shared.dataTask(with: request).resume()
		}
		```

### UIScrollView 관련 헤맸던 부분
- scrollView는 ``ContentSize``를 지정해주어야 동작이 가능하다.
- Paging을 사용하기 위해선 ``isPagingEnabled``을 ``true``로 지정해두어야 한다.
- 참고: http://www.edwith.org/boostcourse-ios/lecture/16900/

## 실행화면
![screemsh_step7_4](./img/Step7-1.png)
![screemsh_step7_5](./img/Step7-2.png)
