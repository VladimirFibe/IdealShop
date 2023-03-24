import SwiftUI

struct ProductNavigation {
    let onExitTap: Callback?
}

final class ProductViewController: ViewController {
    private let navigation: ProductNavigation
    
    init(navigation: ProductNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var rootView: BridgedView = {
        ProductDetatilVeiw(product: Product(
            category: "Games",
            name: "Xbox ONE",
            price: 500,
            discount: nil,
            image_url: "https://www.tradeinn.com/f/13754/137546834/microsoft-xbox-xbox-one-s-1tb-console-additional-controller.jpg")).bridge()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        setupRootView()
    }
    
    private func setupRootView() {
        addChild(rootView)
        view.addSubview(rootView.view)
        rootView.didMove(toParent: self)
        rootView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootView.view.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
