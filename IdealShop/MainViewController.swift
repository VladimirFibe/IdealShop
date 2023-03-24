import SwiftUI

struct MainNavigation {
    let tap: Callback
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
}

struct MainRow: Hashable {
    var index: Int
    var title: String
    var items: [MainItem]
}

enum MainSection: Int, CaseIterable {
    case latest
}

struct MainContent {
    let latest: [Product]
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(LatestCollectionViewCell.self, forCellWithReuseIdentifier: LatestCollectionViewCell.id)
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
        view.addSubview(collectionView)
        setupSearchField()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let margin = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margin.topAnchor),
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
        self.navigation.tap()
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
                            image_url: "https://www.dhresource.com/0x0/f2/albu/g8/M01/9D/19/rBVaV1079WeAEW-AAARn9m_Dmh0487.jpg"),
                    Product(category: "Games",
                            name: "Sony Playstation 5",
                            price: 700,
                            discount: nil,
                            image_url: "https://avatars.mds.yandex.net/get-mpic/6251774/img_id4273297770790914968.jpeg/orig"),
                    Product(category: "Games",
                            name: "Xbox ONE",
                            price: 500,
                            discount: nil,
                            image_url: "https://www.tradeinn.com/f/13754/137546834/microsoft-xbox-xbox-one-s-1tb-console-additional-controller.jpg"),
                    Product(category: "Cars",
                            name: "BMW X6M",
                            price: 35000,
                            discount: nil,
                            image_url: "https://mirbmw.ru/wp-content/uploads/2022/01/manhart-mhx6-700-01.jpg")
                ].map { .latest($0)})
    ]
}

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Title"
        let stackView = UIStackView(arrangedSubviews: [title])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
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
