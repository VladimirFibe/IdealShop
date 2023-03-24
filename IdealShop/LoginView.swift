import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.isLogin ? "Welcome back" : "Sign in")
                .idealText(26, weight: .semibold)
                .padding(.bottom, 70)
            TabView(selection: $viewModel.isLogin) {
                VStack(spacing: 35.0) {
                    IdealTextField(placeholder: "first name", text: $viewModel.firstname)
                    IdealTextField(placeholder: "Last Name", text: $viewModel.lastname)
                    IdealTextField(placeholder: "Email", text: $viewModel.email)
                }.tag(false)
                VStack(spacing: 35.0) {
                    IdealTextField(placeholder: "first name", text: $viewModel.firstname)
                    IdealTextField(placeholder: "Password", text: $viewModel.password, showEye: true)
                    Spacer()
                }.tag(true)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 157, alignment: .top)
            .padding(.bottom, 35)
            
            Button(action: viewModel.login) {
                    PrimaryButton(title: viewModel.isLogin ? "Login" : "Sign in", image: nil)
            }
            
            HStack {
                Text(viewModel.isLogin ? "Don't have accoutn?" : "Already have a account?")
                    .foregroundColor(.quantityText)
                Button {
                    withAnimation {
                        viewModel.isLogin.toggle()
                    }
                } label: {
                    Text(viewModel.isLogin ? "Sign in" : "Log in")
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
        .alert(viewModel.message, isPresented: $viewModel.show) {
            Button("OK", role: .cancel) {
                viewModel.email = ""
                viewModel.message = ""
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(action: {}))
    }
}
