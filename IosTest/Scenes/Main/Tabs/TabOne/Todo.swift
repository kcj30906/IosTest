import Foundation

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
