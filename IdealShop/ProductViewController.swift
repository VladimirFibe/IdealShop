import SwiftUI

struct ProductNavigation {
    let onExitTap: Callback?
}

final class ProductViewController: ViewController {
    private let viewModel = ProductViewModel()
    private let navigation: ProductNavigation
    private let product: Product
    init(navigation: ProductNavigation, product: Product) {
        self.navigation = navigation
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var rootView: BridgedView = {
        ProductDetatilVeiw(viewModel: self.viewModel).bridge()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        setupRootView()
        setupBackButton()
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
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonDidTap))
    }
    
    @objc private func onBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
