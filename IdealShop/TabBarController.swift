import UIKit

final class TabBarController: UITabBarController, BaseViewController {
    var onRemoveFromNavigationStack: (() -> Void)?
    var onDidDismiss: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar().self, forKey: "tabBar")
    }
}
