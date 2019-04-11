## StoreApp



### Step 1

![screen](./1.png)

* JSON Parsing 에 **JSONDecoder** 활용하기
* Text Customizing 하기





**JSONDecoder 활용**

 활용하기 앞서 두 가지의 프로토콜이 존재한다. 이 두가지 프로토콜을 채택하게 되면 그 타입은 밑의 설명과 같이 사용이 가능해진다.

* `Decodable` : 자신을 외부표현에서 디코딩 가능한 타입으로 바꿀 수 있음
* `Encodable` : 자신을 외부표현으로 인코딩할 수 있는 타입으로 바꿀 수 있음
* `Codable` : 자신을 외부표현으로 인코딩 외부표현에서 디코딩이 전부 가능해짐

 우선 이번스텝에서는 `Decodable` 을 채택하고 `JSONDecoder` 을 사용해 외부표현에서 디코딩하였다. 과정을 살펴보면 다음과 같다.

 내가 디코딩하고자 하는 타입에 `Decodable` 프로토콜을 채택해주어야 한다.

```swift
class StoreItem: Decodable {
    private var detail_hash: String
    private var image: String
    private var alt: String
    private var delivery_type: [String]
    private var title: String
    private var description: String
    private var n_price: String?
    private var s_price: String
    private var badge: [String]?
}
```

`StoreItem` 타입으로 디코딩할 준비가 끝났다. 다음은 Decoding을 해줄 JSONDecoder 객체를 생성하여야한다.

```swift
let decoder = JSONDecoder()
guard let data = jsonData.data(using: .utf8) else { return }
// jsonData는 json형식의 String으로된 데이터를 Data타입으로 반환하는 과정
decoder.decode(StoreItem.self, from: data)
// 이렇게 하면 완료된다.
```





**UILabel Text Customizing**

 String을 Customizing하기 위해선 `NSAttributedString` 타입을 사용한다. Objective-c의 타입이다. 우선 Label의 text를 Customizing하기 위해서 `UILabel`의 `attributedText` 프로퍼티를 활용했다.

 다양한 모양으로 텍스트를 꾸밀 수 있었는데 이번 스텝에서는 글자 중간에 줄을 긋는 것만을 사용하였다.

```swift
let label: UILabel = UILabel()
label.attributedText = NSAttributedString(string: text, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
// attributes: 부분에 [NSAttributedString.Key: Any]? 타입이 들어가는데
// .Key 부분에는 스타일을 지정할 수 있는 타입이 들어간다. Any 부분에는 저 값을 통해서 정도를 
//  Any 부분에는 저 값을 통해서 정도를 조절할 수 있다.
```



 