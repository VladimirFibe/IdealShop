import Foundation

typealias Callback = () -> Void

final class AppCoordinator: BaseCoordinator {
    var login = true
    override func start() {
        if login {
            login = false
            runLogin()
        } else {
            runTabBar()
        }
    }
    
    private func runLogin() {
        let coordinator = LoginCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabBar() {
        let coordinator = TabBarCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
