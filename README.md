# swift - storeapp

# Step1
> 커스텀 셀 구현, JSONDecoder 사용

### 작업
1. 커스텀 셀 구현
2. JSONDecoder 사용하여 json 파일을 파싱하였습니다.
3. StackView 를 구현하여 price 와 badge 유무에 따른 display 여부를 결정하였습니다.
4. (재사용을 위한) Custom StackView 적용 : Price, Badge
5. Attributable Protocol 적용 : Basic, Price, Badge Attributes 
6. Decorating Protocol 적용 : StoreItemCell, PriceView, BadgeView

### 첨부파일
![Step1](CaptureImage/Step1.png)

# Step2
> 오토레이아웃 적용

### 작업
1. 오토레이아웃 적용
2. Step1 에서 마무리 못한 관리부분 수정 : 각 스택뷰 안에 있는 라벨들은 스택뷰에서 관리하도록 변경 (Xcode 버그인 것인지 이전 단계에서 드래그 허용(?)이 되지 않아 cell 에서 addSubview 하도록 했었는데 역으로 스택뷰에서 객체 만들고 스토리보드로 드래그해서 매칭시켰습니다.) 

### 작업 중 문제점
 - TableViewController 가 아닌 ViewController 에 Delegate & Datasource 를 따르려고 했기 때문에 컨트롤러 안에 따로 추가했던 테이블뷰의 레이아웃이 넘어가는 문제때문에 원하던 결과가 나오지 않게 되었습니다.
 - 이를 수정하기 위해 테이블뷰 역시 오토레이아웃 적용을 하여 고정을 시키고 하위 뷰들의 오토레이아웃을 적용 시켰습니다.
 
 ### 첨부파일
 ![Step2_5s](CaptureImage/Step2/Step2_5s.png) 
![Step2_8](CaptureImage/Step2/Step2_8.png)
![Step2_8plus](CaptureImage/Step2/Step2_8plus.png)
![Step2_X](CaptureImage/Step2/Step2_X.png)
![Step2_XR](CaptureImage/Step2/Step2_XR.png)
![Step2_XS](CaptureImage/Step2/Step2_XS.png)
![Step2_XSMax](CaptureImage/Step2/Step2_XSMax.png)

# Step3
> 커스텀 헤더 적용

### 작업
1. 커스텀 헤더 적용
    - StoreHeaderCell
    - Topic Model
2. 오토레이아웃 추가 적용
    - Horizontally in Container : Custom Header 의 중앙정렬
    - 최소 width 적용 : 스토리보드 안에서 >= value 설정하여 최소값 적용

### 첨부파일
![Step3_11](CaptureImage/Step3_11.png) 
![Step3_12](CaptureImage/Step3_21.png) 
![Step3_21](CaptureImage/Step3_12.png) 
![Step3_22](CaptureImage/Step3_22.png) 

# Step4
> Toaster 적용

### 작업
- Toaster 적용
- commit 에는 포함되어 있지 않지만 4.0 버전 기준으로 Toast 파일의 NotificationCenter AddObserver 의 이름을 수정하였습니다.

### 첨부파일
![Step4Demo](CaptureImage/Step4Demo.gif)
