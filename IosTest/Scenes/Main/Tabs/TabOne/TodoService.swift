import Alamofire
import Foundation

protocol TodoServicing {
    func fetchTodo(completion: @escaping (Result<Todo, AFError>) -> Void)
}

struct TodoService: TodoServicing {
    func fetchTodo(completion: @escaping (Result<Todo, AFError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/todos/1")
            .validate()
            .responseDecodable(of: Todo.self) { response in
                completion(response.result)
            }
    }
}
