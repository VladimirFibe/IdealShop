import Foundation

typealias Callback = () -> Void

final class AppCoordinator: BaseCoordinator {
    var login = true
    override func start() {
        if login {
            runLogin()
        } else {
            runTabBar()
        }
        login.toggle()
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
