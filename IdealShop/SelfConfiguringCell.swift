import Foundation

protocol SelfConfiguringCell {
    static var id: String { get }
    func configure(with product: Product)
}
