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
            TabView(selection: $isLogin) {
                VStack(spacing: 35.0) {
                    IdealTextField(placeholder: "first name", text: $firstname)
                    
                    IdealTextField(placeholder: "Last Name", text: $lastname)
                    IdealTextField(placeholder: "Email", text: $email)
                }.tag(false)
                VStack(spacing: 35.0) {
                    IdealTextField(placeholder: "first name", text: $firstname)
                    IdealTextField(placeholder: "Password", text: $password, showEye: true)
                    Spacer()
                }.tag(true)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 157, alignment: .top)
            .padding(.bottom, 35)
            
            Button(action: {action?()}) {
                PrimaryButton(title: isLogin ? "Login" : "Sign in", image: nil)
            }
            
            HStack {
                Text(isLogin ? "Don't have accoutn?" : "Already have a account?")
                    .foregroundColor(.quantityText)
                Button {
                    withAnimation {
                        isLogin.toggle()
                    }
                } label: {
                    Text(isLogin ? "Sign in" : "Log in")
                        .foregroundColor(.primaryColor)
                }
                Spacer()
            }
            .idealText(10, weight: .medium)
            .padding(.vertical, 15)
            Spacer()
            VStack(spacing: 35) {
                LogoButton(text: "Sign in with Google", image: "google")
                LogoButton(text: "Sign in with Apple", image: "apple")
            }
            .padding(.leading, 50)
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
