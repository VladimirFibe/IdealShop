import Foundation

final class ProductViewModel: ObservableObject {
    @Published var product = Product(
        name: "", description: nil, rating: nil, number_of_reviews: nil, discount: nil, category: nil, price: 0, colors: nil,
        image_urls: nil,
        image_url: nil)
    var photos: [String] {
        product.image_urls ?? []
    }
    
    var rating: String {
        String(format: "%0.1f", product.rating ?? 0)
    }
    
    var price: String {
        String(format: "$%0.2f", product.price)
    }
    
    var description: String {
        product.description ?? ""
    }
    
    var review: String {
        if let number = product.number_of_reviews {
            return number == 1 ? "\(number) review" : "\(number) reviews"
        } else {
            return ""
        }
    }
    
    var colors: [String] {
        product.colors ?? []
    }
}
