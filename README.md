# IosTest

스토리보드 기반 iOS 샘플 프로젝트로, 메인 화면의 버튼을 누르면 Alamofire를 통해 `https://jsonplaceholder.typicode.com/todos/1`를 호출하고 결과 제목을 라벨에 표시합니다. CocoaPods로 Alamofire를 연동하도록 구성했습니다.

## 실행 방법 (Xcode)
1. CocoaPods이 설치되어 있지 않다면 `sudo gem install cocoapods`로 설치합니다.
2. 프로젝트 루트에서 Podfile을 기반으로 의존성을 설치합니다.
   ```bash
   pod install
   ```
3. 생성되는 `IosTest.xcworkspace`를 Xcode에서 열고, 시뮬레이터 혹은 실제 기기에서 실행합니다.
4. 앱이 실행되면 메인 화면의 "Call API" 버튼을 눌러 통신 예제를 확인합니다.

> 참고: 이전 Swift Package Manager 기반 예제는 `Sources/` 디렉터리 아래에 남아 있습니다.
