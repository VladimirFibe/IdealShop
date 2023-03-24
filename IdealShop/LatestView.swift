import SwiftUI

struct LatestView: View {
    let product: Product
    var body: some View {
        GeometryReader { gr in
            VStack {
                AsyncImage(url: URL(string: product.image_url)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: gr.size.width, height: gr.size.height)
            .cornerRadius(9)
        }
    }
}
//
//struct LatestView_Previews: PreviewProvider {
//    static var previews: some View {
//        LatestView()
//    }
//}
