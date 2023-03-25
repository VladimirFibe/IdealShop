import Foundation

final class ProductViewModel: ObservableObject {
    @Published var product = Product(
        name: "", description: nil, rating: nil, numberOfReviews: nil, discount: nil, category: nil, price: 0, colors: nil,
        imageUrls: nil,
        imageUrl: nil)
    var photos: [String] {
        product.imageUrls ?? []
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
        if let number = product.numberOfReviews {
            return number == 1 ? "\(number) review" : "\(number) reviews"
        } else {
            return ""
        }
    }
    
    var colors: [String] {
        product.colors ?? []
    }
}
