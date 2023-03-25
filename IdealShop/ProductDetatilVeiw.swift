import SwiftUI

struct ProductDetatilVeiw: View {
    let product: Product

    @State private var selection = 0
    var photos: [String] {
        product.image_urls ?? []
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                TabView(selection: $selection) {
                    ForEach(0..<photos.count, id: \.self) { index in
                        AsyncImage(url: URL(string: photos[index])) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 328, height: 279)
                                .clipShape(RoundedRectangle(cornerRadius: 9))
                                .overlay(
                                    VStack(spacing: 15) {
                                        Button {
                                            
                                        } label: {
                                            Image("heartproduct")
                                        }
                                        Rectangle()
                                            .frame(width: 12, height: 1)
                                        Button {
                                            
                                        } label: {
                                            Image("share")
                                        }
                                    }
                                        .frame(width: 42, height: 95)
                                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.productShareLabel))
                                        .offset(x: 21, y: -18)
                                    , alignment: .bottomTrailing
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(x: -9)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 328, height: 279)
                                .background(Color.gray)
                                .cornerRadius(9)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 279)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(0..<photos.count, id: \.self) { index in
                            AsyncImage(url: URL(string: photos[index])) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 66, height: 38)
                                    .clipShape(RoundedRectangle(cornerRadius: 9))
                                    .scaleEffect(index == selection ? 1.25 : 1)
                                    .shadow(color: index == selection ? Color.black.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 4)
                            } placeholder: {
                                
                                ProgressView()
                                    .frame(width: 66, height: 38)
                                    .background(Color.gray)
                                    .cornerRadius(9)
                            }
                            .onTapGesture {
                                withAnimation {
                                    selection = index
                                }
                            }
                        }
                    }
                    .frame(height: 90)
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20.0) {
                        Text(product.name)
                            .idealText(17, weight: .semibold)
                        Text("Features waterproof, fire, air resistant shoes. all changed when the country of fire attacked")
                            .idealText(9, weight: .regular)
                            .foregroundColor(.quantityText)
                        HStack(spacing: 6.0) {
                            Image("star")
                            Text("3.9")
                                .idealText(9, weight: .semibold)
                            Text("(4000 reviews)")
                                .idealText(9, weight: .regular)
                                .foregroundColor(.quantityText)
                        }
                        Text("Color:")
                            .idealText(10, weight: .semibold)
                            .foregroundColor(.textFieldColor)
                        
                        HStack(spacing: 14.0) {
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color.quantityText)
                            .frame(width: 34, height: 26)
                            RoundedRectangle(cornerRadius: 9)
                                .fill(Color.quantityText)
                            .frame(width: 34, height: 26)
                            RoundedRectangle(cornerRadius: 9)
                                .fill(Color.black)
                            .frame(width: 34, height: 26)
                        }
                    }
                    Spacer()
                    Text("$22,50")
                        .idealText(13, weight: .semibold)
                        .frame(width: 70)
                }
                .padding(.horizontal, 24)
                Spacer()
            }
            .padding(.top, 70)
        }
        .edgesIgnoringSafeArea(.top)
        .overlay(alignment: .bottom) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 17.0) {
                        Text("Quantity:")
                            .idealText(9, weight: .medium)
                            .foregroundColor(.quantityText)
                        HStack(spacing: 20.0) {
                            Button {
                                
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white)
                                    .frame(width: 38, height: 22)
                                    .background(Color.primaryColor)
                                    .cornerRadius(8)
                            }
                            Button {
                                
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white)
                                    .frame(width: 38, height: 22)
                                    .background(Color.primaryColor)
                                    .cornerRadius(8)
                            }
                        }
                        
                    }
                    Spacer()
                    HStack(spacing: 30) {
                        Text("#2,500")
                            .foregroundColor(.addToChartSum)
                        Text("ADD TO CART")
                            .foregroundColor(.white)
                    }
                    .idealText(8, weight: .semibold)
                    .frame(width: 170, height: 44)
                    .background(Color.primaryColor)
                    .cornerRadius(15)
                    .padding(.top, 5)
                }
                Spacer()
            }
            .padding(.top, 14)
            .padding(.horizontal, 24)
            .frame(height: 200)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.quantityBackground)
            )
            .offset(y: 115)
        }
    }
}
