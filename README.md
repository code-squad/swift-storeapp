# 쇼핑앱

## step01. 상품 목록

#### 가이드라인을 이용해 실행화면과 똑같도록 디테일을 살렸습니다.

<img width="400" src="https://user-images.githubusercontent.com/38850628/56467746-ef3d0300-645d-11e9-8184-c764e3c4ce5b.png">

### 배운내용

#### Nib파일 사용법을 배웠습니다.

<img width="400" src="https://user-images.githubusercontent.com/38850628/56467748-efd59980-645d-11e9-9b20-03626926b159.png">

#### `intrinsicContentSize`를 이용하여 UILabel의 여백을 넣을 수 있다는것을 배웠습니다.

```swift
override var intrinsicContentSize: CGSize {
let size = super.intrinsicContentSize
return CGSize(width: size.width + leftInset + rightInset,
height: size.height + topInset + bottomInset)
}
```

#### `NSAttributedString`를 이용하면 <s>Strike Through</s>한 문자열을 만들 수 있다는 것을 배웠습니다.

```swift
func strikeThrough() -> NSAttributedString {
let attributes = [NSAttributedString.Key.strikethroughStyle: 1]
let strikeThroughString = NSAttributedString(string: self,
attributes: attributes)
return strikeThroughString
}

naturalPriceLabel.attributedText = n_price.strikeThrough()
```

#### `Bundle.main`을 이용하여 특정 파일에 접근할 수 있다는 것을 배웠습니다.

```swift
let pathOfData = Bundle.main.path(forResource: "main", ofType: "json")
```

### 실행화면

<img width="400" src="https://user-images.githubusercontent.com/38850628/56467750-efd59980-645d-11e9-851a-a0dfe40c1e30.png">

## step02. 오토레이아웃 적용

### 실행화면

<img width="800" src="https://user-images.githubusercontent.com/38850628/56467749-efd59980-645d-11e9-9352-740d755b3442.png">
