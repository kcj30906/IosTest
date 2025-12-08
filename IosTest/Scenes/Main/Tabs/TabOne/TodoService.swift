import Alamofire
import Foundation

protocol TodoServicing {
    func fetchTodo(completion: @escaping (Result<TabOneTodo, AFError>) -> Void)
}

struct TodoService: TodoServicing {
    func fetchTodo(completion: @escaping (Result<TabOneTodo, AFError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/todos/1")
            .validate()
            .responseDecodable(of: TabOneTodo.self) { response in
                completion(response.result)
            }
    }
}
