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
    let flash_sale: [Product]
}

struct Product: Codable, Hashable {
    let name: String
    let description: String?
    let rating: Double?
    let number_of_reviews: Int?
    let discount: Int?
    let category: String?
    let price: Double
    let colors: [String]?
    let image_urls: [String]?
    let image_url: String?
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
