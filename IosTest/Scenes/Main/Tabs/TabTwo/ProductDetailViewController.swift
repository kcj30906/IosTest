import UIKit

final class ProductDetailViewController: UIViewController {
    private let product: Product

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .systemBlue
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "상품 상세"
        layout()
        configure(with: product)
    }

    private func layout() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 12

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "가격: \(product.price.formatted())원"
        descriptionLabel.text = product.description
    }
}
