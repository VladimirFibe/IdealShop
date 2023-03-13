import SwiftUI

struct LoginView: View {
    let action: Callback?
    @State private var firstname = ""
    @State private var password = ""
    var body: some View {
        VStack(alignment: .center, spacing: 30.0) {
            Text("Welcome back")
            TextField("First Name", text: $firstname)
            SecureField("Password", text: $password)
            Button(action: {
                action?()
            }) {
                Text("Login")
            }
        }
        .padding(.horizontal, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(action: {})
    }
}
