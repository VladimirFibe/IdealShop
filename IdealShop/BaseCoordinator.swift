import Foundation

public protocol Coordinator: AnyObject {
    func start()
}

open class BaseCoordinator: Coordinator {
    public let router: Router
    public var childCoordinators: [Coordinator] = []

    public init(router: Router) {
        self.router = router
    }

    open func start() {}

    public func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }

        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    public func removeDependencies() {
        childCoordinators.removeAll()
    }
}
