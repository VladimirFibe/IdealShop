import SwiftUI

struct ProfileNavigation {
    let onExitTap: Callback?
}

final class ProfileViewController: ViewController {
    private let navigation: ProfileNavigation
    
    init(navigation: ProfileNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var rootView: BridgedView = {
        ProfileView(action: { [weak self] in
            self?.navigation.onExitTap?()
        }).bridge()
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
