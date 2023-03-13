import UIKit

final class TabBarCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    
    override func start() {
        runTab()
    }
    
    private func runTab() {
        let tabBar = makeTabBar()
        router.setRootModule(tabBar, hideBar: true)
        
        let modules = [makeMain(), makeFavorite(), makeBasket(), makeChat(), makeProfile()]
        modules.forEach { coordinator, _ in
            addDependency(coordinator)
            coordinator.start()
        }
        let viewControllers = modules.map { $0.1 }
        tabBar.setViewControllers(viewControllers, animated: false)
    }
}

extension TabBarCoordinator {

    private func makeTabBar() -> BaseViewController & UITabBarController {
        return TabBarController()
    }
    
    private func makeMain() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .main)
        return (coordinator, navigationController)
    }
    
    private func makeFavorite() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = FavoriteCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .favorite)
        return (coordinator, navigationController)
    }
    
    private func makeBasket() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = BasketCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .basket)
        return (coordinator, navigationController)
    }
    
    private func makeChat() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ChatCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .chat)
        return (coordinator, navigationController)
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        let item = UITabBarItem(
            title: nil,
            image: UIImage(named: type.icon),
            selectedImage: UIImage(named: type.activeIcon)?.withRenderingMode(.alwaysOriginal)
        )
        item.imageInsets = UIEdgeInsets(top: 13, left: 0, bottom: -13, right: 0)
        return item
    }
}
