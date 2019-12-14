# Store - app



### STEP 1 - 2  

##### 진행기간(2019/12/4 ~ 2019/12/7)

<img width="300" alt="스크린샷 2019-12-07 오전 12 36 17" src="https://user-images.githubusercontent.com/39197978/70334875-96ee3080-1889-11ea-8843-86225abf59df.png">



#### 공부한 내용 👨‍💻

- `intrinsicContentSize` 사이즈를 이용한 컨텐트와 border 사이에 간격을 넣을 수 있게 구현

  <img width="66" alt="스크린샷 2019-12-07 오전 1 04 27" src="https://user-images.githubusercontent.com/39197978/70336966-86d85000-188d-11ea-9f2c-50145c427738.png">

  ```swift
  override var intrinsicContentSize: CGSize {
          var contentSize = super.intrinsicContentSize
          contentSize.height += 10
          contentSize.width += 10
          return contentSize
      }
  ```

  

- `NSAttributeString` 학습
  - strikethrough 속성을 이용한 취소선 구현
  - https://www.hackingwithswift.com/articles/113/nsattributedstring-by-example 예제 학습
  -  NSAttributeString 을 구현하며, 코드 가독성이 명확해지지 않아서, snapKit을 참고하여 비슷한 컨벤션을 유지하게 구현해보았다.

```swift
// 뱃지 구현
let attributedText = NSMutableAttributedString(string: text)
  
attributedText.beauty
      .fgColor(style.textColor)
			.bgColor(style.bgColor)
      .align(style.align)
      .font(style.font)
  
label.attributedText = attributedText

// 취소선 구현
let price = NSMutableAttributedString(string: price)
price.beauty.align(.center).strikethrough(1)
priceLabel.attributedText = price
```



- 데이터를 가져오는 서비스를 추상화하여 구현

  - DummyData , StubService 클래스를 구현하여 추후 변경에 유연하게 대처할 수 있게 구현.

  <img width="794" alt="스크린샷 2019-12-07 오전 1 00 50" src="https://user-images.githubusercontent.com/39197978/70336733-06195400-188d-11ea-9ada-524de9b9d597.png">



---

### STEP3 - 커스텀 헤더 뷰 구현

##### 진행기간(2019/12/9 ~ 2019/12/10)

<img width="340" alt="스크린샷 2019-12-10 오전 5 07 25" src="https://user-images.githubusercontent.com/39197978/70468777-0aeb3b80-1b0b-11ea-8cec-cc28fc1d39a2.png">



#### 공부한 내용👨‍💻

- **CustomHeaderView** 구현

  - `BadgeView` 재사용을 위한 구현

  

- `Category ` 별로 다른 `EndPoint`구현을 위해 데코레이터 패턴을 적용한 ` MulitEndPoint` 구현

  - `EndPoint.swift`

  - ```swift
    protocol EndPoint: URLRequestConvertible {
        
        var baseURL: URL { get }
        var method: HTTP.Method { get }
        var task: HTTP.Task { get }
        var headers: HTTP.Headers? { get }
        var sampleData: Data? { get }
    }
    
    ```

  - `MultiEndPoint.swift`

    ```swift
    // MARK: - MultiEndPoint
    
    enum MultiEndPoint {
        
        case endPoint(EndPoint)
        
        var endPoint: EndPoint {
            switch self {
            case .endPoint(let endPoint):
                return endPoint
            }
        }
    }
    
    // MARK: - EndPoint
    
    extension MultiEndPoint: EndPoint {
        
        var baseURL: URL {
            return endPoint.baseURL
        }
        
        var method: HTTP.Method {
            return endPoint.method
        }
        
        var task: HTTP.Task {
            return endPoint.task
        }
        
        var headers: HTTP.Headers? {
            endPoint.headers
        }
        
        func asURLRequest() -> URLRequest {
            return endPoint.asURLRequest()
        }
        
        var sampleData: Data? {
            return endPoint.sampleData
        }
    }
    ```

- `DispatchGroup` , 순서가 보장되게 구현

  - `DispatchQueue` 를 `.serial`  하게 하여, 비동기적으로 요청은 하되 순서를 보장하게 구현하였다.

  - ```swift
     let dispatchGroup = DispatchGroup()
     let serialQueue = DispatchQueue(label: "store.fetch", qos: .default)
    ```

  - `DispatchGroup`를 이용해서, 모든 Task가 완료된다음 completion을 1번만 호출하게 구현하였다.

  - ```swift
    dispatchGroup.notify(queue: .global()) {
                completion(.success(stores))
            }
    ```

    