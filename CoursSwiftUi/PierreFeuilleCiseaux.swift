import SwiftUI

struct PierreFeuilleCiseauxView: View {
    @State private var options = ["🪨", "📄", "✂️"]
    @State private var playerChoice = ""
    @State private var computerChoice = ""
    @State private var resultMessage = ""
    @State private var countdownText = "Pierre, feuille, ciseaux..."
    @State private var countdown = 3
    @State private var isCountdownActive = true
    @State private var isGameActive = false
    
    @State private var playerScore = 0
    @State private var computerScore = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(countdownText)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Capsule().fill(Color.white.opacity(0.2)))
                    .onAppear(perform: startCountdown)
                
                if !isCountdownActive && !gameOver {
                    Text("Choisissez votre choix :")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    HStack(spacing: 10) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                playerChose(option)
                            }) {
                                Text(option)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(width: 80, height: 80)
                                    .background(Color.white.opacity(0.15))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .padding(0)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
                
                if isGameActive && !gameOver {
                    Text("Votre choix : \(playerChoice)")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Choix de l'ordinateur : \(computerChoice)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    Text(resultMessage)
                        .font(.title)
                        .bold()
                        .foregroundColor(resultMessage == "Vous avez gagné ce round !" ? .green : .red)
                        .padding(.top)
                }
                
                if !gameOver {
                    VStack(spacing: 10) {
                        Text("Score du joueur : \(playerScore)")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Score de l'ordinateur : \(computerScore)")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 30)
                }

                if gameOver {
                    Text(playerScore == 3 ? "Vous avez gagné la partie !" : "L'ordinateur a gagné la partie !")
                        .font(.largeTitle)
                        .foregroundColor(playerScore == 3 ? .green : .red)
                        .bold()
                        .shadow(color: playerScore == 3 ? .green.opacity(0.5) : .red.opacity(0.5), radius: 5, x: 0, y: 0)
                        .padding(.top, 50)
                    
                    Button(action: resetGame) {
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
    }
    
    func startCountdown() {
        countdownText = "Pierre..."
        countdown = 3
        isCountdownActive = true
        isGameActive = false
        gameOver = false
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            countdown -= 1
            if countdown == 2 {
                countdownText = "Feuille..."
            } else if countdown == 1 {
                countdownText = "Ciseaux..."
            } else if countdown == 0 {
                timer.invalidate()
                countdownText = "Choisissez !"
                isCountdownActive = false
            }
        }
    }
    
    func playerChose(_ choice: String) {
        playerChoice = choice
        computerChoice = options.randomElement()!
        determineWinner()
        isGameActive = true
        
        if playerScore == 3 || computerScore == 3 {
            gameOver = true
        }
    }
    
    func determineWinner() {
        if playerChoice == computerChoice {
            resultMessage = "Égalité !"
        } else if (playerChoice == "Pierre" && computerChoice == "Ciseaux") ||
                  (playerChoice == "Feuille" && computerChoice == "Pierre") ||
                  (playerChoice == "Ciseaux" && computerChoice == "Feuille") {
            resultMessage = "Vous avez gagné ce round !"
            playerScore += 1
        } else {
            resultMessage = "L'ordinateur a gagné ce round !"
            computerScore += 1
        }
    }
    
    func resetGame() {
        playerScore = 0
        computerScore = 0
        playerChoice = ""
        computerChoice = ""
        resultMessage = ""
        startCountdown()
    }
}

struct PierreFeuilleCiseauxView_Previews: PreviewProvider {
    static var previews: some View {
        PierreFeuilleCiseauxView()
    }
}
