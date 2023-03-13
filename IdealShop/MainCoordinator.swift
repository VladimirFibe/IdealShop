import Foundation

final class MainCoordinator: BaseCoordinator {
    override func start() {
        runMain()
    }
    
    private func runMain() {
        let controller = makeMain()
        router.setRootModule(controller)
    }
}

extension MainCoordinator {
    private func makeMain() -> BaseViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .systemBackground
        return controller
    }
}
