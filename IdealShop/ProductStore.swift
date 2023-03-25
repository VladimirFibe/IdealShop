//
//  ProductStore.swift
//  IdealShop
//
//  Created by Vladimir on 25.03.2023.
//

import Combine

enum ProductEvent {
    case didLoad(Product)
}

enum ProductAction {
    case fetch
}

final class ProductStore: Store<ProductEvent, ProductAction> {
    override func handleActions(action: ProductAction) {
        switch action {
        case .fetch:
            statefulCall(fetch)
        }
    }
    
    private func fetch() async throws {
        let product: Product = try await APIClient.shared.makeRequest(path: "f7f99d04-4971-45d5-92e0-70333383c239")
        sendEvent(.didLoad(product))
    }
}
