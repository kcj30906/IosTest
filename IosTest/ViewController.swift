import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        triggerButton.configuration = .filled()
        triggerButton.configuration?.title = "Call API"
        statusLabel.text = "버튼을 눌러 통신을 시작하세요"
    }

    @IBAction func didTapTrigger(_ sender: UIButton) {
        sender.isEnabled = false
        statusLabel.text = "요청 중..."

        AF.request("https://jsonplaceholder.typicode.com/todos/1")
            .validate()
            .responseDecodable(of: Todo.self) { [weak self] response in
                guard let self = self else { return }
                sender.isEnabled = true

                switch response.result {
                case .success(let todo):
                    self.statusLabel.text = "성공: \(todo.title)"
                case .failure(let error):
                    self.statusLabel.text = "실패: \(error.localizedDescription)"
                }
            }
    }
}

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
