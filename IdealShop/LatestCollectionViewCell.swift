import SwiftUI

class LatestCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static let id = "LatestCollectionViewCell"
    func configure(with product: Product) {
        contentConfiguration = UIHostingConfiguration {
            LatestView(product: product)
        }
        .margins(.all, 0)
    }
}
