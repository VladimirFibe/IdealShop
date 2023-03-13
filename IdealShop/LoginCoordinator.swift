import Foundation

final class LoginCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?

    override func start() {
        runLogin()
    }
    
    private func runLogin() {
        let controller = makeLogin()
        router.setRootModule(controller)
    }
}

extension LoginCoordinator {
    private func makeLogin() -> BaseViewController {
        let navigation = LoginNavigation(onLoginTap: onFlowDidFinish)
        return LoginViewController(navigation: navigation)
    }
}
