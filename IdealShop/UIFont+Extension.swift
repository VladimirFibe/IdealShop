import SwiftUI

enum IdealFontWeight: String {
    case black = "Montserrat-Black"
    case medium = "Montserrat-Medium"
    case light = "Montserrat-Light"
    case bold = "Montserrat-Bold"
    case semibold = "Montserrat-SemiBold"
    case regular = "Montserrat-Regular"
}

extension UIFont {
    static func idealFont(_ size: CGFloat, weight: IdealFontWeight) -> UIFont {
        UIFont(name: weight.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension Font {
    static func idealFont(_ size: CGFloat, weight: IdealFontWeight) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}

struct IdealText: ViewModifier {
    let kerning: CGFloat
    let size: CGFloat
    let weight: IdealFontWeight
    func body(content: Content) -> some View {
        content
            .kerning(kerning)
            .font(.idealFont(size, weight: weight))
    }
}

extension View {
    func idealText(_ size: CGFloat, weight: IdealFontWeight, kerning: CGFloat = -0.3) -> some View {
        self.modifier(IdealText(kerning: kerning, size: size, weight: weight))
    }
}
