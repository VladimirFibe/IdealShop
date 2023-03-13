import SwiftUI

final public class RestrictedUIHostingController<Content>: UIHostingController<Content> where Content: View {
    public override var navigationController: UINavigationController? {
        nil
    }
}
