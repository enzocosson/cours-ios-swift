import SwiftUI

struct DevinezLeNombreView: View {
    @State private var randomNumber = Int.random(in: 1...100)
    @State private var playerGuess = ""
    @State private var feedbackMessage = "Devinez un nombre entre 1 et 100"
    @State private var attempts = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Devinez le Nombre")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text(feedbackMessage)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Capsule().fill(Color.white.opacity(0.2)))
                
                TextField("Entrez votre nombre", text: $playerGuess)
                    .keyboardType(.numberPad)
                    .font(.title2)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                
                Button(action: makeGuess) {
                    Text("Valider")
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
                
                if gameOver {
                    Text("Vous avez trouvé le nombre en \(attempts) essais !")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    Button(action: resetGame) {
                        Text("Rejouer")
                            .font(.title)
                            .bold()
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
            }
            .padding()
        }
    }
    
    func makeGuess() {
        guard let guess = Int(playerGuess) else {
            feedbackMessage = "Veuillez entrer un nombre valide."
            return
        }
        
        attempts += 1
        
        if guess < randomNumber {
            feedbackMessage = "Trop bas ! Essayez encore."
        } else if guess > randomNumber {
            feedbackMessage = "Trop haut ! Essayez encore."
        } else {
            feedbackMessage = "Bravo ! Vous avez trouvé le bon nombre."
            gameOver = true
        }
    }
    
    func resetGame() {
        randomNumber = Int.random(in: 1...100)
        playerGuess = ""
        feedbackMessage = "Devinez un nombre entre 1 et 100"
        attempts = 0
        gameOver = false
    }
}

struct DevinezLeNombreView_Previews: PreviewProvider {
    static var previews: some View {
        DevinezLeNombreView()
    }
}
