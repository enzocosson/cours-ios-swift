//
//  DevinezLeNombreModel.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 17/10/2024.
//

import SwiftUI

class DevinezLeNombreModel: ObservableObject {
    @Published var randomNumber = Int.random(in: 1...100)
    @Published var playerGuess = ""
    @Published var feedbackMessage = "Devinez un nombre entre 1 et 100"
    @Published var attempts = 0
    @Published var gameOver = false
    
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
