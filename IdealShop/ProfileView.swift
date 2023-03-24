import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileModel()
    let action: Callback
    var body: some View {
        VStack(spacing: 17) {
            EditableCircularProfileImage(viewModel: viewModel)
            
            Text("Satria Adhi Pradana")
                .idealText(15, weight: .bold)
            
            PrimaryButton(title: "Upload item", image: Image("uploadItem"))
                .frame(width: 290)
                .padding(.top)
            
            buttons
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
    var buttons: some View {
        VStack(spacing: 22) {
            ProfileButton(title: "Trade store", withChevron: true, icon: "card")
            ProfileButton(title: "Payment method", withChevron: true, icon: "card")
            ProfileButton(title: "Balance", withChevron: false, icon: "card", value: "$ 1593")
            ProfileButton(title: "Trade history", withChevron: true, icon: "card")
            ProfileButton(title: "Restore Puschase", withChevron: true, icon: "restore")
            ProfileButton(title: "Help", withChevron: false, icon: "help")
            Button(action: action) {
                ProfileButton(title: "выход", withChevron: false, icon: "logout")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
            ProfileView(action: {})
    }
}

struct ProfileButton: View {
    let title: String
    let withChevron: Bool
    let icon: String
    var value = ""
    var body: some View {
        HStack(spacing: 8){
            Image(icon)
                .resizable()
                .frame(width: 40, height: 40)
            
            Text(title)
                .foregroundColor(.black)
                .idealText(14, weight: .medium)
            Spacer()
            if withChevron {
                Image("chevron")
            } else {
                Text(value)
                    .idealText(14, weight: .medium)
            }
        }
        .foregroundColor(.black)
    }
}
