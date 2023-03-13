import SwiftUI

typealias BridgedView = UIViewController

extension View {
    public func bridge() -> UIHostingController<Self> {
        RestrictedUIHostingController(rootView: self).apply {
            $0.view.backgroundColor = .clear
        }
    }

    public func bridgeAndApply(_ configurator: (UIView) -> Void) -> UIHostingController<Self> {
        bridge().apply { 
            configurator($0.view)
        }
    }
}
