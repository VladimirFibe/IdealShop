import Foundation

enum TabItem: Int {
    case main
    case favorite
    case basket
    case chat
    case profile
    
    var icon: String {
        switch self {
        case .main: return "Home"
        case .favorite: return "Home"
        case .basket: return "Home"
        case .chat: return "Home"
        case .profile: return "Home"
        }
    }
    
    var activeIcon: String {
        switch self {
        case .main: return "Home"
        case .favorite: return "Home"
        case .basket: return "Home"
        case .chat: return "Home"
        case .profile: return "Home"
        }
    }
}
