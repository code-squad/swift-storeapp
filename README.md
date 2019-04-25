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

## step03. Custom Section 헤더 적용

### 배운내용

#### `UILabel`안에 여백을 넣는 법을 배웠다.

```swift
override var intrinsicContentSize: CGSize {
let size = super.intrinsicContentSize
return CGSize(width: size.width + leftInset + rightInset,
height: size.height + topInset + bottomInset)
}
```

### 실행화면

<img width="400" src="https://user-images.githubusercontent.com/38850628/56567105-2bec3400-65ef-11e9-8659-67b9317efde2.gif">

## step04. CocoaPod

### 배운내용

#### 코코아팟 사용법을 익혔다.

#### Workspace
: 하나 이상의 프로젝트. 이 프로젝트들은 대부분 서로 연관되어있다.

#### Project
: 코드와 리소스를 포함한 것.

#### Target
: 각 프로젝트는 하나 이상의 타겟이 있다.

- 각 타겟들은 프로젝트의 빌드 세팅 목록을 정의한다.
- 각 타겟들은 빌드시 포함하거나 사용할 클래스, 리소스, 커스텀 스크립트의 목록 또한 정의한다.
- 타겟들은 대게 같은 프로젝트의 다른 배포판에 사용된다.

#### Scheme
: 스키마는 '빌드', '테스트', '프로파일' 등을 누를때 어떤일이 일어나는지를 정의한다.

- 보통 타겟들은 최소 하나의 스키마를 가지고 있다.
- `Scheme > Manage Schemes`로 가서 `'Autocreate Schemes Now'`를 누름으로써 스키마를 자동생성 할 수 있다.

> 출처: https://stackoverflow.com/questions/20637435/xcode-what-is-a-target-and-scheme-in-plain-language/20637892#20637892

### 실행화면

<img width="400" src="https://user-images.githubusercontent.com/38850628/56709282-61ae2b80-675b-11e9-8cf8-2ec4b6a38db3.gif">
