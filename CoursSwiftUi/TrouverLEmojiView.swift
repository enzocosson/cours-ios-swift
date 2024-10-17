import SwiftUI

struct TrouverLEmojiView: View {
    @StateObject private var gameModel = TrouverLEmojiModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Trouver l'Emoji 🎉")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                if !gameModel.gameOver {
                    Text("Indice : Quel emoji est : '\(gameModel.getEmojiDescription(for: gameModel.targetEmoji))'?")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.white.opacity(0.2)))
                    
                    HStack {
                        ForEach(gameModel.options, id: \.self) { emoji in
                            Button(action: {
                                gameModel.checkGuess(emoji)
                            }) {
                                Text(emoji)
                                    .font(.largeTitle)
                                    .frame(width: 70, height: 70)
                                    .background(Color.white.opacity(0.15))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text("Score : \(gameModel.score)")
                        .font(.headline)
                        .foregroundColor(.white)
                } else {
                    Text(gameModel.score >= 5 ? "Vous avez gagné ! 🎉" : "Partie terminée. 😢")
                        .font(.largeTitle)
                        .foregroundColor(gameModel.score >= 5 ? .green : .red)
                        .bold()
                        .padding(.top, 50)
                    
                    Button(action: gameModel.resetGame) {
                        Text("Rejouer")
                            .font(.title)
                            .bold()
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
            }
            .padding()
        }
        .onAppear(perform: gameModel.startGame)
    }
}

struct TrouverLEmojiView_Previews: PreviewProvider {
    static var previews: some View {
        TrouverLEmojiView()
    }
}
