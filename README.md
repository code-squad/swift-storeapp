# 진행사항

## Step 1

- 상품목록 구현하였습니다.
- main.json 파일을 읽어서 상품목록 데이터를 조회하였습니다.
- Decodable 활용하여 StoreItems 구조체 안에 StoreItem 배열을 넣었습니다.
- MenuTableViewCell 에 해당 IndexPath 순서에 맞는 StoreItem 데이터를 넘기고, 텍스트 정보를 표시하였습니다.
- HeaderView 구현과 상품기본가격이 없을 때 할인가격 Label 왼쪽 여백 조정이 필요합니다.
<img src="https://user-images.githubusercontent.com/1483784/42416993-34ae73ca-82b8-11e8-84bf-e7a483de3193.png" width="414">

## Step 2

- AutoLayout 정리
- 스토리보드 ViewController에 Cell을 Content View를 기준으로 하위 뷰들에 오토레이아웃을 적용한다.
- 모든 아이폰 사이즈에 대응해서 잘리는 화면이 없이 나와야 한다.
- 상품기본가격이 없을 때 할인가격 Label 왼쪽 여백 조정을 하였습니다. 스토리보드에서 LayoutConstraint 을 IBOutlet 변수로 선언하여 처리하였습니다.
- badge 값에 따라 이벤트 뱃지 노출 처리하였습니다.

iPhone 5s | iPhone X
------------ | -------------
<img src="https://user-images.githubusercontent.com/1483784/42417000-4851b7ac-82b8-11e8-84d7-3af25d8fe080.png" width="320"> | <img src="https://user-images.githubusercontent.com/1483784/42416994-3520740c-82b8-11e8-9e0f-7e780e3b995f.png" width="375">

## Step 3

- 스토리보드 ViewController에 Cell에 Section Header로 사용할 Custom Cell을 추가한다.
- 총 섹션은 3개로 구분해서 헤더에 표시한다.
- 섹션헤더 추가하였습니다
- MenuHeaderView 를 분리하였는데, 피드백부탁드리겠습니다.
- MVC에서는 View 과 Model 이 분리되어 있어야 한다고 하여, 고민이 되었습니다.
- StoreInfo 데이터 배열을 관리하는 Store 상위 모델을 만들어서 분리하였습니다.
- StoreInfo 에는 섹션헤더를 채울 정보와 메뉴정보 배열이 있습니다.
- StoreItem, StoreItems 같이 헷갈릴 수 있는 이름은 신경써야겠습니다.

## Step 4

- Cocoapod 를 설치한다. 설치 가이드
- https://github.com/devxoul/Toaster 저장소에 있는 Toaster 패키지를 cocoapod 으로 설치한다.
- pod으로 설치한 Toaster 모듈을 import 하고 테이블뷰 셀을 터치하면 (didSelect) 타이틀 메뉴와 (할인된)최종 가격 정보를 toast 형태로 표시한다.
- pod 'Toaster' 로 설치하였습니다.
- UITableViewDelegate didSelectRowAt 에서 toast 띄웠습니다
<img src="https://user-images.githubusercontent.com/1483784/42720648-f2fb9f04-8765-11e8-9e90-1e154fe96158.png" width="320">

# 진행 방법

- 쇼핑 iOS 앱 요구사항을 파악한다.
- 요구사항에 대한 구현을 완료한 후 자신의 github 아이디에 해당하는 브랜치에 Pull Request(이하 PR)를 통해 코드 리뷰 요청을 한다.
- 코드 리뷰 피드백에 대한 개선 작업을 하고 다시 PUSH한다.
- 모든 피드백을 완료하면 다음 단계를 도전하고 앞의 과정을 반복한다.

# 코드 리뷰 과정
> 저장소 브랜치에 자신의 github 아이디에 해당하는 브랜치가 존재해야 한다.
>
> 자신의 github 아이디에 해당하는 브랜치가 있는지 확인한다.

1. 자신의 github 아이디에 해당하는 브랜치가 없는 경우 브랜치 생성 요청 채널을 통해 브랜치 생성을 요청한다.
프로젝트를 자신의 계정으로 fork한다. 저장소 우측 상단의 fork 버튼을 활용한다.

2. fork한 프로젝트를 자신의 컴퓨터로 clone한다.
```
git clone https://github.com/{본인_아이디}/{저장소 아이디}
ex) https://github.com/godrm/swift-storeapp
```

3. clone한 프로젝트 이동
```
cd {저장소 아이디}
ex) cd swift-storeapp
```

4. 본인 아이디로 브랜치를 만들기 위한 checkout
```
git checkout -t origin/본인_아이디
ex) git checkout -t origin/godrm
```

5. 기능 구현을 위한 브랜치 생성 (연속번호를 붙여나간다)
```
git checkout -b 브랜치이름
ex) git checkout -b store-step1
```

6. commit
```
git status //확인
git rm 파일명 //삭제된 파일
git add 파일명(or * 모두) // 추가/변경 파일
git commit -m "메세지" // 커밋
```

7. 본인 원격 저장소에 올리기
```
git push --set-upstream origin 브랜치이름
ex) git push --set-upstream origin store-step1
```

8. pull request
	- pull request는 github 서비스에서 진행할 수 있다.
	- pull request는 original 저장소의 브랜치(자신의 github 아이디)와 앞 단계에서 생성한 브랜치 이름을 기준으로 한다.

	```
	ex) code-squad/swift-photoframe godrm 브랜치 기준 => godrm/swift-storeapp store-step1
	```
	
9. code review 및 push
	- pull request를 통해 피드백을 받는다.
	- 코드 리뷰 피드백에 대한 개선 작업을 하고 다시 PUSH한다.

10. 기본(upstream) 브랜치 전환 및 base 저장소 추가하기(최초 시작하기 단계 한번만 하면 됨)

	```
	git checkout 본인_아이디
	git remote add upstream base_저장소_url

	ex) git checkout godrm
	ex) git remote add upstream https://github.com/code-squad/swift-storeapp.git
	```

	- 위와 같이 base 저장소 추가한 후 remote 브랜치 목록을 본다.

	```
	git remote -v
	```

11. 기본 base 저장소와 sync하기 (PR 보낸 내용을 자신의 기본 저장소와 합치기)

	```
	git fetch upstream
	git rebase upstream/본인_아이디
	ex) git rebase upstream/godrm
	```

12. 다음 미션을 해결할 경우 [5단계 브랜치 생성]부터 다시 진행

## 동영상을 통한 코드 리뷰() 를 통해 참고 가능

- [fork하여 코드 리뷰하기](https://www.youtube.com/watch?v=ZSZoaG0PqLg) 
- [PR 보내고 다시 PR보낼 때 유의 사항](https://www.youtube.com/watch?v=CbLNbCUsh5c&feature=youtu.be)

## 실습 중 모든 질문은 슬랙 채널에서...