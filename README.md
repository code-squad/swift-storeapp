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

## step05. Network 프로그래밍

### 배운내용

#### `UIRefreshControl`에 대해서 배웠습니다.

```swift
tableView.refreshControl = UIRefreshControl()
tableView.refreshControl?.addTarget(self, action: #selector(updateStoreItems), for: .valueChanged)
```

#### 코코아터치 프레임워크를 추가하고 사용하는 방법을 배웠습니다.

- `Embedded Binaries`에 추가해서 사용하면 됩니다.
- 프레임워크를 만들때는 접근레벨을 잘 적용해줘야 합니다.

#### Dispatch에 대해 배웠습니다.

**!필독!** [https://medium.com/@yostane/swift-sweet-bits-the-dispatch-framework-ios-10-e34451d59a86](https://medium.com/@yostane/swift-sweet-bits-the-dispatch-framework-ios-10-e34451d59a86)의 글을 번역한 글입니다.

Dispatch 프레임워크는 병행성 코드 작성을 위한 클래스로 구성되어있다. 이것은 iOS, macOS, tvOS, watchOS를 지원한다.

GCD에서 이해해야할 메인 컨셉은 `DispatchQueue`이다. 이것은 `blocks`나 `DispatchWorkItems`에 의해 제출된 작업들을 위한 컨테이너이다. `DispatchQueue`안에 작업을 `WorkItem`이라고 부른다. `DispatchQueue`안에 `WorkItme`들은 FIFO순서로 당겨진다.

`DispatchQueue`는 `Serial`하거나 `Concurrent`하게 사용할 수 있습니다. `Serial Queue`는 순차적으로 하나씩 실행합니다. `Concurrent Queue`는 `WorkItem`들을 FIFO순서로 Queue에 넣고 동시에 실행합니다. `Concurrent Queue`의 경우에는 `WorkItem`들의 완료 순서를 예측할 수 없습니다.

Dispatch 프레임워크로 시스템이 제공한 Queue들을 조작할 수 있습니다.

- `main queue`로 `work item`을 `main thread`에 보낼 수 있습니다.
- 서로 다른 QoS(Quality of Service)를 사용하는 Global concurrent queues

`DispatchQueue`클래스는 발송 대기열 개념을 캡슐화 한 것이다. `DispatchWorkItem` 클래스는 발송 작업 항목의 개념을 캡슐화 한 것이다.

몇가지 DispatchQueue의 함수들을 연습해보자

##### DispatchQueue

이 예에서는 우리는 `global queue`에서 동시에 두가지 반복문을 실행 할 것이다.

```swift
//two concurrent loops
DispatchQueue.global().async {
for i in 1...5 {
print("global async \(i)")
}
}
DispatchQueue.global().async {
for i in 1...5 {
print("global async 2 \(i)")
}
}
```
실행화면

```
global async 1
global async 2 1
global async 2 2
global async 2
global async 2 3
global async 3
global async 2 4
global async 4
global async 2 5
global async 5

```

`.global()`함수는 기본 global queue를 반환한다. 비동기 함수는 실행의 흐름이 block의 완료를 기다리지 않는것을 의미한다. 만약 네가 block의 완료를 기다리고 싶으면 `sync()`메서드를 대신 사용해라. `sync`와 `async`둘다 다른 파라미터를 사용하는데 가장 일반적인 방법은 block을 전달하는 것이다.

여기, 우리는 다른 QoS Queue의 블록들을 실행할 것이다.

```swift

DispatchQueue.global(qos: .background).async {
for i in 1...5 {
print("global async \(i)")
}
}
DispatchQueue.global(qos: .userInteractive).async {
for i in 1...5 {
print("global async 2 \(i)")
}
}
```

실행화면

```
global async 1
global async 2 1
global async 2 2
global async 2 3
global async 2
global async 2 4
global async 2 5
global async 3
global async 4
global async 5

```

`Quality of Service(QoS)`는 우선순위를 부여하고 시스템 성능을 최적화 시켜준다. 우선순위가 높은 순부터 낮은 순으로 작성하였다.(아래 표의 내용은 [https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html)에서 가져왔습니다.)

| 이름 | 설명 | 시간 |
| --- | --- | --- |
| User-interactive | 메인 스레드에서 작동하거나 유저인터페이스를 새로고침할때, 애니메이션을 수행할때 등 유저와 상호작용하는 작업에 사용합니다. 빠르게 작동하지 않으면 유저인터페이스가 동결된 것처럼 보입니다. 반응성과 성능에 초점을 맞췄습니다. | 즉각반응 |
| User-initiated | 사용자가 무언갈 클릭할때, 저장된 문서를 열거나 작업을 수행하는 등 사용자가 즉시 작업을 시작하고 결과를 요구하는 작업을 할 때 사용합니다. | 거의 즉시, 몇 초 이하 |
| Utility | 데이터를 다운로드하거나 가져오는 것과 같이 즉각적인 결과가 필요하지 않은 작업을 완료하는데 시간이 걸릴 수 있습니다. 유틸리티 작업에는 일반적으로 사용자가 볼 수 있는 진행 표시줄이 있습니다. 반응성, 성능 및 에너지 효율간의 균형을 제공하는데 초점을 맞춤. | 몇 초에서 몇 분 |
| Background | 백그라운드에서 작동하며 인덱싱, 동기화 및 백업과 같이 사용자가 볼 수 없는 작업. 에너지 효율에 초점을 맞추고 있습니다. | 몇 분에서 몇 시간 정도의 상당한 시간 |


##### DispatchWorkItem

DispatchWorkItem 클래스는 작업 항목의 개념을 캡슐화한 것이다. 이를 사용하기 위해 블록을 사용하여 인스턴스를 초기화한 다음 현재 스레드에서 실행하거나 발송 대기열에 제출할 수 있다.

```swift
let dwi = DispatchWorkItem {
for i in 1...5 {
print("DispatchWorkItem \(i)")
}
}
//현재 스레드에서 수행
dwi.perform()
//global queue에서 수행
DispatchQueue.global().async(execute: dwi)
```

dispatch work item에는 취소 플래그가 있다. 실행 전에 취소되면, dispatch queue에서 실행되지 않고 건너뛴다. 실행 중에 취소된 경우 취소 속성은 True를 반환한다. 그 경우, 우리는 실행을 멈출 수 있다.

dispatch work item이 완료되었을때 실행할 work item도 지정할 수 있다.

```swift
let dwi3 = DispatchWorkItem {
print("start DispatchWorkItem")
sleep(2)
print("end DispatchWorkItem")
}
//this block will be executed on a the siqpatch queue 'dq' when dwi3 completes
let myDq = DispatchQueue(label: "A custom dispatch queue")
dwi3.notify(queue: myDq) {
print("notify")
}
DispatchQueue.global().async(execute: dwi3)
```

실행화면

```
start DispatchWorkItem
end DispatchWorkItem
notify
```

##### DispatchGroup

dispatch group은 다른 queue에서 실행하더라도 다른 work items의 완료를 추적할 수 있다.

```swift

let dispatchWorkItem = DispatchWorkItem{
print("work item start")
sleep(1)
print("work item end")
}

let dg = DispatchGroup()
//submiy work items to the group
let dispatchQueue = DispatchQueue(label: "custom dq")
dispatchQueue.async(group: dg) {
print("block start")
sleep(2)
print("block end")
}
DispatchQueue.global().async(group: dg, execute: dispatchWorkItem)
//print message when all blocks in the group finish
dg.notify(queue: DispatchQueue.global()) {
print("dispatch group over")
}
```

실행화면

```
block start
work item start
work item end
block end
dispatch group over

```



### 실행화면

<img width="400" src="https://user-images.githubusercontent.com/38850628/56865312-a0680e00-6a07-11e9-989a-21ec9aef7fae.gif">
