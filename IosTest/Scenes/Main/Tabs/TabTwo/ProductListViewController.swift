import UIKit

final class ProductListViewController: UIViewController {
    private let viewModel: ProductListViewModel

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "더미 상품"
        view.backgroundColor = .systemBackground
        layout()
        bindViewModel()
        viewModel.viewDidLoad()
    }

    private func layout() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func bindViewModel() {
        viewModel.onProductsUpdated = { [weak self] _ in
            guard let self else { return }
            errorLabel.isHidden = true
            tableView.reloadData()
        }

        viewModel.onLoadingStateChange = { [weak self] isLoading in
            guard let self else { return }

            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
                tableView.refreshControl?.endRefreshing()
            }
        }

        viewModel.onErrorMessageChange = { [weak self] message in
            guard let self else { return }
            errorLabel.text = message
            errorLabel.isHidden = message.isEmpty
        }
    }

    @objc
    private func didPullToRefresh() {
        viewModel.refresh()
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let product = viewModel.product(at: indexPath.row) {
            var configuration = UIListContentConfiguration.valueCell()
            configuration.text = product.name
            configuration.secondaryText = "\(product.price.formatted())원"
            cell.contentConfiguration = configuration
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let product = viewModel.product(at: indexPath.row) else { return }
        let detailViewController = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
