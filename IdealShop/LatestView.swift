import SwiftUI

struct LatestView: View {
    let product: Product
    var body: some View {
        GeometryReader { gr in
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: product.imageUrl ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(product.category ?? "")
                            .idealText(6, weight: .semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .foregroundColor(.black)
                            .background(.thinMaterial)
                        .cornerRadius(5)
                        Text(product.name)
                            .idealText(9, weight: .semibold)
                        Text(String(format: "$%.0f", product.price))
                            .idealText(7, weight: .semibold)
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(size: 10))
                        .frame(width: 20, height: 20)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                }
                .padding(7)
                .frame(width: gr.size.width)
            }
            .frame(width: gr.size.width, height: gr.size.height)
            .cornerRadius(9)
        }
    }
}
