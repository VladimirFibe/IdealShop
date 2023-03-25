import SwiftUI

struct FlashSaleView: View {
    let product: Product
    var body: some View {
        GeometryReader { gr in
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: product.image_url ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Image("man")
                        Spacer()
                        Text(product.category ?? "")
                            .idealText(9, weight: .semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .foregroundColor(.black)
                            .background(.thinMaterial)
                        .cornerRadius(5)
                        Text(product.name)
                            .idealText(13, weight: .semibold)
                            .shadow(radius: 2)
                            .lineLimit(2)
                        Text(String(format: "$%.2f", product.price))
                            .idealText(10, weight: .semibold)
                            .shadow(radius: 2)
                    }
                    .foregroundColor(.white)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(product.discount ?? 0)% off")
                            .idealText(10, weight: .semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .clipShape(Capsule())
                        Spacer()
                        HStack(spacing: 5.0) {
                            Image(systemName: "heart")
                                .font(.system(size: 12))
                                .frame(width: 28, height: 28)
                                .background(.thinMaterial)
                            .clipShape(Circle())
                            Image(systemName: "plus")
                                .font(.system(size: 16))
                                .frame(width: 35, height: 35)
                                .background(.thinMaterial)
                            .clipShape(Circle())
                        }
                    }
                }
                .padding(7)
                .frame(width: gr.size.width)
            }
            .frame(width: gr.size.width, height: gr.size.height)
            .cornerRadius(9)
        }
    }
}
