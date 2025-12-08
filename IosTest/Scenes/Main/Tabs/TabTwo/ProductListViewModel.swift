import Foundation

final class ProductListViewModel {
    private let productService: ProductServicing
    private(set) var products: [Product] = []

    var onProductsUpdated: (([Product]) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    var onErrorMessageChange: ((String) -> Void)?

    init(productService: ProductServicing) {
        self.productService = productService
    }

    func viewDidLoad() {
        fetchProducts()
    }

    func refresh() {
        fetchProducts()
    }

    func product(at index: Int) -> Product? {
        guard products.indices.contains(index) else { return nil }
        return products[index]
    }

    private func fetchProducts() {
        onLoadingStateChange?(true)
        onErrorMessageChange?("")

        productService.fetchProducts { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.onLoadingStateChange?(false)

                switch result {
                case .success(let products):
                    self.products = products
                    self.onProductsUpdated?(products)
                case .failure(let error):
                    self.onErrorMessageChange?("불러오기 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
