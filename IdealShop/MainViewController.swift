import SwiftUI

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
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "latest")
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.id)
        return collectionView
    }()
    
    
    private var dataSource: DataSource!
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
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
            case let .latest(product):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latest", for: indexPath)
                cell.contentConfiguration = UIHostingConfiguration{LatestView(product: product)}
                
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            headerView.title.text = self?.viewModel.rows[indexPath.section].title
            return headerView
        }
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
}

final class MainViewModel {
    var rows = [
        MainRow(index: MainSection.latest.rawValue,
                title: "Latest",
                items: [
                    Product(category: "Kids",
                            name: "New Balance Sneakers",
                            price: 22.5, discount: 30,
                            image_url: "https://newbalance.ru/upload/iblock/697/iz997hht_nb_02_i.jpg")
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
