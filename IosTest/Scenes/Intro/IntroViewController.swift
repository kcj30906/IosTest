import UIKit

final class IntroViewController: UIViewController {
    private let viewModel: IntroViewModel
    private var startWorkItem: DispatchWorkItem?

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
        label.text = "잠시 후 메인 화면으로 이동합니다."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let testImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = IntroViewController.makeTestImage()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.accessibilityLabel = "TEST"
        return imageView
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scheduleAutoStartIfNeeded()
    }

    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [testImageView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        testImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            testImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            testImageView.heightAnchor.constraint(equalTo: testImageView.widthAnchor)
        ])
    }

    private func scheduleAutoStartIfNeeded() {
        guard startWorkItem == nil else { return }

        let workItem = DispatchWorkItem { [weak self] in
            self?.viewModel.requestStart()
        }

        startWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: workItem)
    }

    deinit {
        startWorkItem?.cancel()
    }

    private static func makeTestImage() -> UIImage? {
        let size = CGSize(width: 260, height: 260)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 24)
            UIColor.systemBlue.setFill()
            path.fill()

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 56),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]

            let text = "TEST"
            let textSize = text.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (size.width - textSize.width) / 2,
                y: (size.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )

            text.draw(in: textRect, withAttributes: attributes)
        }
    }
}
