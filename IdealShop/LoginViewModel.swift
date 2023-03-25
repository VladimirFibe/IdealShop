import Foundation

final class LoginViewModel: ObservableObject {
    let action: Callback?
    @Published var isLogin = false
    @Published var firstname = "Vladimir"
    @Published var lastname = ""
    @Published var password = "123456"
    @Published var email = ""
    @Published var show = false
    @Published var message = ""
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    init(action: Callback?) {
        self.action = action
    }
    
    private func showMessage(_ message: String) {
        show = true
        self.message = message
    }
    
    func login() {
        if isLogin {
            if let person = CoreDataMamanager.shared.fetchPerson(firstname: firstname) {
                if person.password == password {
                    action?()
                } else {
                    showMessage("не верный пароль")
                }
            } else {
                showMessage("\(firstname) нет такого имени")
            }
        } else {
            if isValidEmail {
                if firstname.isEmpty || lastname.isEmpty {
                    showMessage("все поля являются обязательными")
                } else {
                    if let person = CoreDataMamanager.shared.fetchPerson(firstname: firstname) {
                        showMessage("пользователь с именем \(person.firstname ?? "") уже существует. Выберите другое имя")
                    } else {
                        CoreDataMamanager.shared.createPerson(withEmail: email, firstname: firstname, lastname: lastname)
                        firstname = ""
                        lastname = ""
                        email = ""
                        showMessage("Спасибо!")
                    }
                }
            } else {
                showMessage("\(email) неверная почта")
            }
        }
    }
}
