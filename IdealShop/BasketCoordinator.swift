import Foundation

final class BasketCoordinator: BaseCoordinator {
    override func start() {
        runBascket()
    }
    
    private func runBascket() {
        let controller = makeBascket()
        router.setRootModule(controller)
    }
}

extension BasketCoordinator {
    private func makeBascket() -> BaseViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .idealBackground
        return controller
    }
}
