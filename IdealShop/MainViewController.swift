import SwiftUI

struct MainNavigation {
    let tap: (Product) -> ()
}
struct Product: Codable, Hashable {
    let category: String
    let name: String
    let price: Double
    let discount: Int?
    let image_url: String
}

enum MainItem: Hashable {
    case latest(Product)
    case flash(Product)
    case brands(Product)
}

struct MainRow: Hashable {
    var index: Int
    var title: String
    var items: [MainItem]
}

enum MainSection: Int, CaseIterable {
    case latest
    case flash
    case brands
}

struct MainContent {
    let latest: [Product]
    let flash: [Product]
    let brands: [Product]
}

private typealias DataSource = UICollectionViewDiffableDataSource<MainRow, MainItem>
private typealias Snapshot = NSDiffableDataSourceSnapshot<MainRow, MainItem>

final class MainViewController: ViewController {
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
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .idealBackground
        addChild(headerView)
        view.addSubview(headerView.view)
        headerView.didMove(toParent: self)
        headerView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        setupSearchField()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margin = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.view.topAnchor.constraint(equalTo: margin.topAnchor),
            headerView.view.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            headerView.view.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            headerView.view.heightAnchor.constraint(equalToConstant: 60),
            collectionView.topAnchor.constraint(equalTo: headerView.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ])
        configureDataSouce()
        reloadData()
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
    
    func setupSearchField() {
        let searchController = UISearchController()
        searchController.isActive = true
        searchController.searchBar.placeholder = "What are you looking for?"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
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

final class MainViewModel {
    var rows = [
        MainRow(index: MainSection.latest.rawValue,
                title: "Latest",
                items: [
                    Product(category: "Phones",
                            name: "Samsung S10",
                            price: 1000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679312995136-4bfc25c1936f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    Product(category: "Games",
                            name: "Sony Playstation 5",
                            price: 700,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1674574124475-16dd78234342?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                    Product(category: "Games",
                            name: "Xbox ONE",
                            price: 500,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1661956601349-f61c959a8fd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80"),
                    Product(category: "Cars",
                            name: "BMW X6M",
                            price: 35000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679493464629-76f6575fe739?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
                ].map { .latest($0)}),
        MainRow(index: MainSection.flash.rawValue,
                title: "Flash Sale",
                items: [
                    Product(category: "Phones",
                            name: "Samsung S10",
                            price: 1000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679312995136-4bfc25c1936f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    Product(category: "Games",
                            name: "Sony Playstation 5",
                            price: 700,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1674574124475-16dd78234342?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                    Product(category: "Games",
                            name: "Xbox ONE",
                            price: 500,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1661956601349-f61c959a8fd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80"),
                    Product(category: "Cars",
                            name: "BMW X6M",
                            price: 35000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679493464629-76f6575fe739?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
                ].map { .flash($0)}),
        MainRow(index: MainSection.brands.rawValue,
                title: "Brands",
                items: [
                    Product(category: "Phones",
                            name: "Samsung S10",
                            price: 1000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679312995136-4bfc25c1936f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    Product(category: "Games",
                            name: "Sony Playstation 5",
                            price: 700,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1674574124475-16dd78234342?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                    Product(category: "Games",
                            name: "Xbox ONE",
                            price: 500,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1661956601349-f61c959a8fd4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80"),
                    Product(category: "Cars",
                            name: "BMW X6M",
                            price: 35000,
                            discount: nil,
                            image_url: "https://images.unsplash.com/photo-1679493464629-76f6575fe739?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
                ].map { .brands($0)})
    ]
}

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    let button = UIButton(type: .system)
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Title"
        button.setTitle("View all", for: .normal)
        button.tintColor = .lightGray
        let stackView = UIStackView(arrangedSubviews: [title, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
