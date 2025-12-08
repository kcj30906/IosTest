import UIKit

final class TodoViewController: UIViewController {
    private let viewModel: TodoViewModel

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let triggerButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Call API", for: .normal)
        return button
    }()

    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        bindViewModel()
        triggerButton.addTarget(self, action: #selector(didTapTrigger), for: .touchUpInside)
        viewModel.viewDidLoad()
    }

    private func layout() {
        view.addSubview(statusLabel)
        view.addSubview(triggerButton)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        triggerButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            statusLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),

            triggerButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 32),
            triggerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onStatusTextChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.statusLabel.text = text
            }
        }

        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.triggerButton.isEnabled = !isLoading
            }
        }
    }

    @objc
    private func didTapTrigger() {
        viewModel.fetchTodo()
    }
}
