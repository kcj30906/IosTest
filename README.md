# IosTest
스토리보드 기반 iOS 샘플 프로젝트로, 메인 화면의 버튼을 누르면 Alamofire를 통해 `https://jsonplaceholder.typicode.com/todos/1`를 호출하고 결과 제목을 라벨에 표시합니다. 이제 Xcode 프로젝트에 Swift Package Manager로 Alamofire가 직접 연결되어 별도 의존성 설치가 필요하지 않습니다.

## 실행 방법 (Xcode)
1. `IosTest.xcodeproj`를 Xcode에서 바로 엽니다. (별도의 `pod install` 과정이 필요 없습니다.)
2. 시뮬레이터 혹은 실제 기기에서 실행합니다.
3. 앱이 실행되면 메인 화면의 "Call API" 버튼을 눌러 통신 예제를 확인합니다.

> 참고: 이전 Swift Package Manager 기반 예제는 `Sources/` 디렉터리 아래에 남아 있습니다.

