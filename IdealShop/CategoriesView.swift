//
//  CategoriesView.swift
//  IdealShop
//
//  Created by Vladimir on 24.03.2023.
//

import SwiftUI

struct CategoriesView: View {
    var categories = ["Phones", "Headphones", "Games", "Cars", "Furniture", "Kids"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 17.0) {
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Image(category)
                        Text(category)
                            .idealText(8, weight: .medium)
                    }
                }
            }
            .padding(15)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
