import Foundation

final class MainViewModel {
    var mainContent: MainContent? {
        didSet {
            rows = [
                MainRow(index: MainSection.latest.rawValue,
                        title: "Latest",
                        items: (mainContent?.latest ?? []).map { .latest($0)}),
                MainRow(index: MainSection.flash.rawValue,
                        title: "Flash Sale",
                        items: (mainContent?.flash ?? []).map { .flash($0)}),
                MainRow(index: MainSection.brands.rawValue,
                        title: "Brands",
                        items: (mainContent?.brands ?? []).map { .brands($0)})
            ]
        }
    }
    var rows: [MainRow] = []
}

struct LatestResponse: Codable {
    let latest: [Product]
}

struct FlashResponse: Codable {
    let flashSale: [Product]
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

struct Product: Codable, Hashable {
    let name: String
    let description: String?
    let rating: Double?
    let numberOfReviews: Int?
    let discount: Int?
    let category: String?
    let price: Double
    let colors: [String]?
    let imageUrls: [String]?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, rating
        case numberOfReviews = "number_of_reviews"
        case discount, category, price, colors
        case imageUrls = "image_urls"
        case imageUrl = "image_url"
    }
}

enum MainItem: Hashable {
    case latest(Product)
    case flash(Product)
    case brands(Product)
}

struct MainRow: Hashable {
    var index: Int
    var title: String
    var items: [MainItem]
}

enum MainSection: Int, CaseIterable {
    case latest
    case flash
    case brands
}

struct MainContent {
    let latest: [Product]
    let flash: [Product]
    let brands: [Product]
}
