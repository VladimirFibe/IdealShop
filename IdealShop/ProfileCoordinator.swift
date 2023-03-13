import Foundation

final class ProfileCoordinator: BaseCoordinator {
    override func start() {
        runProfile()
    }
    
    private func runProfile() {
        let controller = makeProfile()
        router.setRootModule(controller)
    }
}

extension ProfileCoordinator {
    private func makeProfile() -> BaseViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .systemBackground
        return controller
    }
}
