import Foundation

final class FavoriteCoordinator: BaseCoordinator {
    override func start() {
        runFavorite()
    }
    
    private func runFavorite() {
        let controller = makeFavorite()
        router.setRootModule(controller)
    }
}

extension FavoriteCoordinator {
    private func makeFavorite() -> BaseViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .idealBackground
        return controller
    }
}
