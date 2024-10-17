import SwiftUI

struct MainView: View {
    @StateObject private var authModel = ModelAuth()
    @State private var showError: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.168, green: 0.165, blue: 0.176, opacity: 1.0),
                        Color(red: 0.125, green: 0.125, blue: 0.125, opacity: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if authModel.isValid {
                    VStack {
                        NavigationLink(destination: MenuAppView()) {
                            Text("Accéder à la liste des applications")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()

                        Button(action: logout) {
                            Text("Se déconnecter")
                                .font(.headline)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                } else {
                    VStack(spacing: 20) {
                        Text("Connexion")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 20)

                        TextField("Nom d'utilisateur", text: $authModel.username)
                            .padding()
                            .background(Color(red: 0.22, green: 0.22, blue: 0.22, opacity: 1.0))
                            .foregroundColor(Color(red: 0.506, green: 0.506, blue: 0.506, opacity: 1.0))
                            .cornerRadius(12)
                            .frame(width: 280, height: 44)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onSubmit { authenticate() }

                        SecureField("Mot de passe", text: $authModel.password)
                            .padding()
                            .background(Color(red: 0.22, green: 0.22, blue: 0.22, opacity: 1.0))
                            .foregroundColor(Color(red: 0.506, green: 0.506, blue: 0.506, opacity: 1.0))
                            .cornerRadius(12)
                            .frame(width: 280, height: 44)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onSubmit { authenticate() }

                        if showError {
                            Text("Nom d'utilisateur ou mot de passe incorrect")
                                .foregroundColor(.red)
                                .padding()
                        }

                        Button(action: authenticate) {
                            Text("Se connecter")
                                .fontWeight(.semibold)
                                .frame(width: 240, height: 25)
                                .padding()
                                .background(Color(red: 0.22, green: 0.22, blue: 0.22, opacity: 1.0))
                                .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.92, opacity: 1.0))
                                .cornerRadius(50)
                        }
                        .padding()
                    }
                    .padding()
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                }
            }
        }
    }

    private func authenticate() {
        authModel.checkCredentials()
        showError = !authModel.isValid
    }

    private func logout() {
        authModel.isValid = false
        authModel.username = ""
        authModel.password = ""
    }
}

#Preview {
    MainView()
}
