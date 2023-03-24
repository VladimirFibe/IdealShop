import SwiftUI

struct PrimaryButton: View {
    let title: String
    let image: Image?
    var body: some View {
        Text(title)
            .font(.idealFont(14, weight: .semibold))
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .foregroundColor(.primaryTextColor)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.primaryColor)
            )
            .overlay(alignment: .leading) {
                if let image {
                    image.padding(.leading, 50)
                } else {
                    EmptyView()
                }
            }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Upload item", image: nil)
            .padding(.horizontal)
    }
}
