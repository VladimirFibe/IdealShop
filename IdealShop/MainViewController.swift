import SwiftUI
import Combine

struct MainNavigation {
    let tap: (Product) -> ()
}

private typealias DataSource = UICollectionViewDiffableDataSource<MainRow, MainItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<MainRow, MainItem>

final class MainViewController: ViewController {
    private let store = MainStore()
    private let viewModel = MainViewModel()
    private var bag = Bag()
    
    let navigation: MainNavigation
    init(navigation: MainNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headerView: BridgedView = {
        CategoriesView().bridge()
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(LatestCollectionViewCell.self, forCellWithReuseIdentifier: LatestCollectionViewCell.id)
        collectionView.register(FlashCollectionViewCell.self, forCellWithReuseIdentifier: FlashCollectionViewCell.id)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        return collectionView
    }()
    
    private var dataSource: DataSource!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .idealBackground
        addChild(headerView)
        view.addSubview(headerView.view)
        headerView.didMove(toParent: self)
        headerView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margin = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.view.topAnchor.constraint(equalTo: margin.topAnchor),
            headerView.view.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            headerView.view.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            headerView.view.heightAnchor.constraint(equalToConstant: 170),
            collectionView.topAnchor.constraint(equalTo: headerView.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ])
        configureDataSouce()
        setupObservers()
        store.sendAction(.fetch)
    }
    private func configureDataSouce() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let item = self.viewModel.rows[indexPath.section].items[indexPath.row]
            switch item {
            case let .latest(product): return self.configure(LatestCollectionViewCell.self, with: product, for: indexPath)
            case let .flash(product): return self.configure(FlashCollectionViewCell.self, with: product, for: indexPath)
            case let .brands(product): return self.configure(LatestCollectionViewCell.self, with: product, for: indexPath)
            }
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            headerView.title.text = self?.viewModel.rows[indexPath.section].title
            return headerView
        }
    }
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with product: Product, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as? T
        else { fatalError("Unable to dequeue \(cellType)")}
        cell.configure(with: product)
        return cell
    }
    
    private func reloadData() {
        var snapshot = Snapshot()
        let rows = viewModel.rows
        snapshot.appendSections(rows)
        rows.forEach {
                snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupObservers() {
        bindLoading(to: view, from: store).store(in: &bag)
        
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .didLoadSections(content):
                    self.viewModel.mainContent = content
                    self.reloadData()
                }
            }.store(in: &bag)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            switch item {
            case .brands(let product): self.navigation.tap(product)
            case .flash(let product): self.navigation.tap(product)
            case .latest(let product): self.navigation.tap(product)
            }
        }
    }
}

extension UIViewController {
    func bindLoading(to view: UIView, from loadingObservable: LoadingObservable) -> AnyCancellable {
        loadingObservable.loadingViewModel
            .$isLoading
            .receiveOnMainQueue()
            .removeDuplicates()
            .sink { isLoading in
                view.isLoading(isLoading)
            }
    }
    
    func bindLoading(to view: UIView, from loadingViewModel: LoadingViewModel) -> AnyCancellable {
        view.withLoading()
        
        return loadingViewModel
            .$isLoading
            .receiveOnMainQueue()
            .removeDuplicates()
            .sink { isLoading in
                view.isLoading(isLoading)
            }
    }
}

extension UIView {
    @discardableResult
    func withLoading() -> UIKitLoadingView {
        let loadingView = UIKitLoadingView()
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return loadingView
    }
    
    func isLoading(_ isLoading: Bool) {
        var loadingView = subviews.compactMap { $0 as? UIKitLoadingView }.first
        if loadingView == nil {
            loadingView = self.withLoading()
        }
        if isLoading {
            self.bringSubviewToFront(loadingView!)
            loadingView?.play()
        } else {
            loadingView?.stop()
        }
    }
}

final class UIKitLoadingView: UIView {
    private let artificialDebouncingPeriod: TimeInterval = 0
    private var inProgress = false
    
    private lazy var loadingView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        alpha = 0
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func play() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
        loadingView.startAnimating()
    }
    
    func stop() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.loadingView.stopAnimating()
        }
    }
    
    func configureConstraints() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension Publisher {
    public func receiveOnMainQueue() -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: DispatchQueue.main)
    }
}
