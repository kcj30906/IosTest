import Foundation

final class TodoViewModel {
    private let todoService: TodoServicing

    var onStatusTextChange: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?

    init(todoService: TodoServicing) {
        self.todoService = todoService
    }

    func viewDidLoad() {
        onStatusTextChange?("버튼을 눌러 통신을 시작하세요")
    }

    func fetchTodo() {
        onLoadingStateChange?(true)
        onStatusTextChange?("요청 중...")

        todoService.fetchTodo { [weak self] result in
            guard let self = self else { return }
            self.onLoadingStateChange?(false)

            switch result {
            case .success(let todo):
                self.onStatusTextChange?("성공: \(todo.title)")
            case .failure(let error):
                self.onStatusTextChange?("실패: \(error.localizedDescription)")
            }
        }
    }
}
