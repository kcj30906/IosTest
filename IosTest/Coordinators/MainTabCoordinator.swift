import UIKit

final class MainTabCoordinator: Coordinator {
    let navigationController: UINavigationController
    private let tabBarController = MainTabBarController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let todoService = TodoService()
        let tabOneViewModel = TodoViewModel(todoService: todoService)
        let tabOne = TodoViewController(viewModel: tabOneViewModel)
        tabOne.title = "탭 1"
        tabOne.tabBarItem = UITabBarItem(title: "탭 1", image: UIImage(systemName: "1.circle"), tag: 0)

        let productService = ProductService()
        let tabTwoViewModel = ProductListViewModel(productService: productService)
        let tabTwo = ProductListViewController(viewModel: tabTwoViewModel)
        tabTwo.tabBarItem = UITabBarItem(title: "탭 2", image: UIImage(systemName: "2.circle"), tag: 1)

        let tabThree = PlaceholderViewController(titleText: "탭 3")
        tabThree.tabBarItem = UITabBarItem(title: "탭 3", image: UIImage(systemName: "3.circle"), tag: 2)

        tabBarController.viewControllers = [tabOne, tabTwo, tabThree].map { UINavigationController(rootViewController: $0) }
        tabBarController.selectedIndex = 0

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
