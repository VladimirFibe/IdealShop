//
//  IdealTextField.swift
//  IdealShop
//
//  Created by Vladimir on 21.03.2023.
//

import SwiftUI

struct IdealTextField: View {
    let placeholder: String
    @Binding var text: String
    var showEye = false
    var body: some View {
        Group {
            if showEye {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .multilineTextAlignment(.center)
        .idealText(11, weight: .medium)
        .frame(height: 29)
        .foregroundColor(.textFieldColor)
        .background(Capsule().fill(Color.textfieldBackground))
        .overlay(
            Group {
                if showEye {
                    Image("eyeoff")
                        .padding(.trailing, 15)
                } else { EmptyView()}
            }
            , alignment: .trailing
        )
    }
}

struct IdealTextField_Previews: PreviewProvider {
    static var previews: some View {
        IdealTextField(placeholder: "First name", text: .constant(""))
            .padding(.horizontal, 50)
    }
}
