import SwiftUI

struct LoginView: View {
    let action: Callback?
    @State private var isLogin = false
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var email = ""
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(isLogin ? "Welcome back" : "Sign in")
                .idealText(26, weight: .semibold)
                .padding(.bottom, 70)
            VStack {
                IdealTextField(placeholder: "first name", text: $firstname)
                if isLogin {
                    IdealTextField(placeholder: "Password", text: $password, showEye: true)
                } else {
                    IdealTextField(placeholder: "Last Name", text: $lastname)
                    IdealTextField(placeholder: "Email", text: $email)
                }
                Spacer(minLength: 0)
            }
            .frame(height: 157)
            .padding(.bottom, 25)

            Button(action: {action?()}) {
                PrimaryButton(title: isLogin ? "Login" : "Sign in", image: nil)
            }

            HStack {
                Text("Already have a account?")
                Button {
                    isLogin.toggle()
                } label: {
                    Text("Log in")
                }

            }
            .idealText(10, weight: .medium)
            .padding(.bottom)
            VStack {
                LogoButton(text: "Sign in with Google", image: "google")
                LogoButton(text: "Sign in with Apple", image: "apple")
            }
            Spacer()
        }
        .padding(.horizontal, 50)
        .padding(.top, 100)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(action: {})
    }
}
