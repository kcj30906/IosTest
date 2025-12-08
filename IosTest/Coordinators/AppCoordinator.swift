import UIKit

final class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showIntro()
    }

    private func showIntro() {
        let introViewModel = IntroViewModel()
        let introViewController = IntroViewController(viewModel: introViewModel)

        introViewModel.onStartRequested = { [weak self] in
            self?.showMainTabs()
        }

        navigationController.setViewControllers([introViewController], animated: false)
    }

    private func showMainTabs() {
        let mainCoordinator = MainTabCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
}
