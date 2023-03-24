import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        runMain()
    }
    
    private func runMain() {
        let controller = makeMain()
        router.setRootModule(controller)
    }
    
    private func runProduct() {
        let controller = makeProduct()
        router.push(controller, hideBottomBar: false)
    }
}

extension MainCoordinator {
    private func makeMain() -> BaseViewController {
        return MainViewController(navigation: MainNavigation(tap: {[weak self] in
            self?.runProduct()
        }))
    }
    
    private func makeProduct() -> BaseViewController {
        return ProductViewController(navigation: ProductNavigation(onExitTap: {}))
    }
}
