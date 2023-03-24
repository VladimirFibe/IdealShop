//
//  LogoButton.swift
//  IdealShop
//
//  Created by Vladimir on 21.03.2023.
//

import SwiftUI

struct LogoButton: View {
    let text: String
    let image: String
    var body: some View {
        Label(text, image: image)
            .idealText(12, weight: .medium)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct LogoButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoButton(text: "Apple", image: "apple")
            .padding(.leading, 15)
    }
}
