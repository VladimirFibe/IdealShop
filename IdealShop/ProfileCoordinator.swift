import Foundation

final class ProfileCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    
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
        let controller = ProfileViewController(navigation: ProfileNavigation(onExitTap: { [weak self] in
            self?.onFlowDidFinish?()
        }))
        return controller
    }
}
