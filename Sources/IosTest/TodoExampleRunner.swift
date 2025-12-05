import Foundation
import Alamofire

/// 간단한 예제 실행기를 통해 Alamofire 호출 흐름을 보여줍니다.
/// 실제 서버가 아닌 URLProtocol 스텁을 사용해 네트워크 없이도 동작합니다.
final class TodoExampleRunner {
    private let client: NetworkClient
    private let semaphore = DispatchSemaphore(value: 0)

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)

        let baseURL = URL(string: "https://example.com")!
        self.client = NetworkClient(baseURL: baseURL, session: session)
    }

    func runExample() {
        // 스텁 응답 정의
        let todo = Todo(id: 1, title: "Alamofire example", completed: false)
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url.absoluteString.contains("/todos/1") else {
                throw URLError(.badURL)
            }

            let data = try JSONEncoder().encode(todo)
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }

        client.fetchTodo(id: 1) { [weak self] result in
            defer { self?.semaphore.signal() }

            switch result {
            case let .success(received):
                print("✅ Fetched todo: id=\(received.id), title=\(received.title), completed=\(received.completed)")
            case let .failure(error):
                print("❌ Failed to fetch todo: \(error)")
            }
        }

        _ = semaphore.wait(timeout: .now() + 2)
    }
}

// MARK: - Mock URL Protocol

final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            client?.urlProtocol(self, didFailWithError: URLError(.unknown))
            return
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}
