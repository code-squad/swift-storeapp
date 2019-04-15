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





### Step 2

![screen](./2.png)

*  AutoLayout이 CustomCell 에서 적용되지 않음



**Custom Cell AutoLayout 적용**

 처음 작업할 때, MainStoryboard에서 Constraint를 적용해주었다. 그런데 예상과 다르게 실행하였을 때 레이아웃이 적용이 되지않았다.

 Cell을 TableView에 만들고 Custom으로 적용해줄 때 Custom Class를 등록해준다. 그 때 Content View의 Custom Class도 함께 설정이 되어진다.

![ㅁㅈㅇ](./3.png)

 여기서 Content View를 선택 후, Custom Class를 UIView로 바꿔주어야 한다. Custom Class로 지정되어있을 시, Interface Builder에서 인식을 하지 못하는 듯했다.



**실행화면**

<img src="5s.png" height="500px"/> <img src="6.png" height="500px"/>

<img src="7.png" height="500px"/><img src="8.png" height="500px"/>

<img src="XS.png" height="500px"/><img src="XSmax.png" height="500px"/>





### Step 3

![awd](./9.png)

* TableView Section Header를 ProtoType Cell을 이용하여 Custom하기



**TableView Section Header Custom 하기**

 Custom Cell을 이용하여 Header를 만들기 때문에, 이전에 TableView에서 Cell을 만들어주었던 것과 동일하게 StoryBoard에서 TableView에 Cell을 하나 생성해준다. 그 후 Custom Cell을 만들어주었던 것과 동일하게 Custom Class를 만들어주고 연결시켜준다.

 그럼 이 Custom Cell을 `TableViewDataSource` 에서 생성해주는 것이 아닌 `TableViewDelegate` `func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?` 메소드를 활용하여 생성해줄 것이다.

```swift
// Section Header에 사용 될 테이블 뷰 셀
class StoreHeaderCell: UITableViewCell {
  @IBOutlet weak var themeLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
}

// Delegate를 구현한 클래스
class StoreAppDelegate: NSObject ,UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: 			StoreHeaderCell.identifier) as? StoreHeaderCell else { return UITableViewCell() }
    cell.set(at: section)
    return cell
  }
}
```



**실행화면**

<img src="10.png" height="500px"/><img src="11.png" height="500px"/>

