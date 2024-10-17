import SwiftUI

struct DevinezLeNombreView: View {
    @StateObject private var gameModel = DevinezLeNombreModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Devinez le Nombre")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text(gameModel.feedbackMessage)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Capsule().fill(Color.white.opacity(0.2)))
                
                TextField("Entrez votre nombre", text: $gameModel.playerGuess)
                    .keyboardType(.numberPad)
                    .font(.title2)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                
                Button(action: gameModel.makeGuess) {
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
                
                if gameModel.gameOver {
                    Text("Vous avez trouvé le nombre en \(gameModel.attempts) essais !")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    Button(action: gameModel.resetGame) {
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
}

struct DevinezLeNombreView_Previews: PreviewProvider {
    static var previews: some View {
        DevinezLeNombreView()
    }
}
