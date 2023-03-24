import UIKit

final class CustomTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { nil }
    private func setup() {
        layer.cornerRadius = 30
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
}
