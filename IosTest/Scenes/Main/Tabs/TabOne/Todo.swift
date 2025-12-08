import Foundation

struct TabOneTodo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
