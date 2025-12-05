import Foundation

@main
struct IosTest {
    static func main() {
        print("Alamofire networking demo. 스텁을 사용해 실제 네트워크 없이 결과를 확인합니다.")
        let runner = TodoExampleRunner()
        runner.runExample()
    }
}
