import Foundation

final class ChatCoordinator: BaseCoordinator {
    override func start() {
        runChat()
    }
    
    private func runChat() {
        let controller = makeChat()
        router.setRootModule(controller)
    }
}

extension ChatCoordinator {
    private func makeChat() -> BaseViewController {
        let controller = ViewController()
        controller.view.backgroundColor = .systemBackground
        return controller
    }
}
