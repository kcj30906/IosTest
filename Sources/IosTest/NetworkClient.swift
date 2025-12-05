import Foundation
import Alamofire

struct Todo: Decodable, Equatable {
    let id: Int
    let title: String
    let completed: Bool
}

protocol NetworkClientProtocol {
    func fetchTodo(
        id: Int,
        completion: @escaping (Result<Todo, AFError>) -> Void
    )
}

final class NetworkClient: NetworkClientProtocol {
    private let session: Session
    private let baseURL: URL

    init(baseURL: URL, session: Session = .default) {
        self.baseURL = baseURL
        self.session = session
    }

    func fetchTodo(id: Int, completion: @escaping (Result<Todo, AFError>) -> Void) {
        let todoURL = baseURL.appendingPathComponent("todos/\(id)")

        session
            .request(todoURL, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Todo.self) { response in
                completion(response.result)
            }
    }
}
