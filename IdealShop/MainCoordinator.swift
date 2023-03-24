import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        runMain()
    }
    
    private func runMain() {
        let controller = makeMain()
        router.setRootModule(controller)
    }
    
    private func runProduct(_ product: Product) {
        let controller = makeProduct(product)
        router.push(controller, hideBottomBar: false)
    }
}

extension MainCoordinator {
    private func makeMain() -> BaseViewController {
        return MainViewController(navigation: MainNavigation(tap: {[weak self] product in
            self?.runProduct(product)
        }))
    }
    
    private func makeProduct(_ product: Product) -> BaseViewController {
        return ProductViewController(navigation: ProductNavigation(onExitTap: {}), product: product)
    }
}
