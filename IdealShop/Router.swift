import UIKit

public protocol Router {
    var rootController: UINavigationController? { get }
    func present(_ module: BaseViewController?)
    func present(_ module: BaseViewController?, animated: Bool)
    func present(_ module: BaseViewController?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: BaseViewController?)
    func push(_ module: BaseViewController?, hideBottomBar: Bool)
    func push(_ module: BaseViewController?, animated: Bool)
    func push(_ module: BaseViewController?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: BaseViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool)
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: BaseViewController?)
    func setRootModule(_ module: BaseViewController?, hideBar: Bool)
    func setRootModules(_ modules: [BaseViewController], hideBar: Bool)
    func popToRootModule(animated: Bool)
}

public final class RouterImpl: Router {
    public weak var rootController: UINavigationController?
    private var completions: [UIViewController: () -> Void]

    public init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    public func present(_ module: BaseViewController?) {
        present(module, animated: true)
    }

    public func present(_ module: BaseViewController?, animated: Bool) {
        guard let module = module else {
            return
        }

        rootController?.present(module, animated: animated, completion: nil)
    }
    
    public func present(_ module: BaseViewController?, animated: Bool, completion: (() -> Void)?) {
        guard let module = module else {
            return
        }

        rootController?.present(module, animated: animated, completion: completion)
    }

    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool) {
        rootController?.dismiss(animated: animated)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    public func push(_ module: BaseViewController?) {
        push(module, animated: true)
    }

    public func push(_ module: BaseViewController?, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }

    public func push(_ module: BaseViewController?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    public func push(_ module: BaseViewController?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: true, completion: completion)
    }

    public func push(_ module: BaseViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard let module = module, module is UINavigationController == false
        else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[module] = completion
        }
        module.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(module, animated: animated)
    }

    public func popModule() {
        popModule(animated: true)
    }

    public func popModule(animated: Bool) {
        if let module = rootController?.popViewController(animated: animated) as? BaseViewController {
            runCompletion(for: module)
        }
    }

    public func setRootModule(_ module: BaseViewController?) {
        setRootModule(module, hideBar: false)
    }

    public func setRootModule(_ module: BaseViewController?, hideBar: Bool) {
        guard let module = module else {
            return
        }

        rootController?.setViewControllers([module], animated: false)
        rootController?.navigationBar.isHidden = hideBar
    }
    
    public func setRootModules(_ modules: [BaseViewController], hideBar: Bool) {
        guard !modules.isEmpty else {
            return
        }

        rootController?.setViewControllers(modules, animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }

    public func popToRootModule(animated: Bool) {
        if let modules = rootController?.popToRootViewController(animated: animated) {
            modules.forEach { module in
                if let module = module as? BaseViewController {
                    runCompletion(for: module)
                }
            }
        }
    }

    private func runCompletion(for controller: BaseViewController) {
        guard let module = controller as? ViewController,
              let completion = completions[module]
        else { return }
        completion()
        completions.removeValue(forKey: module)
    }
}

extension UINavigationController {
    func replaceTopViewController(with viewController: UIViewController, animated: Bool = true) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }
}
