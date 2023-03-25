import SwiftUI

extension UIColor {
    static let idealBackground = #colorLiteral(red: 0.9845501781, green: 0.9820036292, blue: 1, alpha: 1)
    static let idealSearchField = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    
}

extension Color {
    static let primaryColor = Color("primary")
    static let primaryTextColor = Color("primaryText")
    static let textfieldBackground = Color("textFieldBackground")
    static let textFieldColor = Color("textFieldColor")
    static let productShareLabel = Color("productShareLabel")
    static let quantityText = Color("quantityText")
    static let quantityBackground = Color("quantityBackground")
    static let addToChartSum = Color("addToChartSum")
}

extension Color {
    public init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        return nil
    }
}
