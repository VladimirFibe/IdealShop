import SwiftUI

class FlashCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static let id = "FlashCollectionViewCell"
    func configure(with product: Product) {
        contentConfiguration = UIHostingConfiguration {
            FlashSaleView(product: product)
        }
        .margins(.all, 0)
    }
}
