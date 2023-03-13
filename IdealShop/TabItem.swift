import Foundation

enum TabItem: Int {
    case main
    case favorite
    case basket
    case chat
    case profile
    
    var icon: String {
        switch self {
        case .main: return "home"
        case .favorite: return "heart"
        case .basket: return "basket"
        case .chat: return "chat"
        case .profile: return "person"
        }
    }
    
    var activeIcon: String {
        switch self {
        case .main: return "home_selected"
        case .favorite: return "heart_selected"
        case .basket: return "basket_selected"
        case .chat: return "chat_selected"
        case .profile: return "person_selected"
        }
    }
}
