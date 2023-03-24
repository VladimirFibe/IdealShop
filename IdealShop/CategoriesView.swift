import SwiftUI

struct CategoriesView: View {
    var categories = ["Phones", "Headphones", "Games", "Cars", "Furniture", "Kids"]
    @State private var text = ""
    var body: some View {
        VStack {
            HStack {
                Image("menu")
                Spacer()
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 32)
            }
            .padding(.horizontal, 15)
            .overlay {
                Text("Trade by ")
                +
                Text("bata")
                    .foregroundColor(.primaryColor)
            }
            .idealText(20, weight: .bold)
            HStack {
                Spacer()
                Text("Location")
                    .idealText(10, weight: .regular)
                Image("down")
            }
            .padding(.trailing, 35)
            IdealTextField(placeholder: "What are you looking for ?", text: $text)
                .overlay(alignment: .trailing) {
                    Image("search").padding(.trailing, 16)
                }
                .padding(.horizontal, 35)
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
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
