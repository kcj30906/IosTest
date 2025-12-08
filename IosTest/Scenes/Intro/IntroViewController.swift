import UIKit

final class IntroViewController: UIViewController {
    private let viewModel: IntroViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "인트로 화면"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "메인 탭 화면으로 이동해보세요."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.configuration = .filled()
        return button
    }()

    init(viewModel: IntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "인트로"
        layout()
        startButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
    }

    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, startButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        startButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }

    @objc
    private func didTapStart() {
        viewModel.didTapStart()
    }
}
