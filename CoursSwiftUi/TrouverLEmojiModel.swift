//
//  TrouverLEmojiModel.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 17/10/2024.
//

import SwiftUI

class TrouverLEmojiModel: ObservableObject {
    @Published var emojis = ["😀", "😂", "🥳", "😎", "😍", "🤔", "🤩", "😢", "😡"]
    @Published var targetEmoji = ""
    @Published var options = [String]()
    @Published var resultMessage = ""
    @Published var score = 0
    @Published var gameOver = false
    
    func startGame() {
        score = 0
        gameOver = false
        generateNewRound()
    }
    
    func generateNewRound() {
        targetEmoji = emojis.randomElement() ?? ""
        options = (1...3).map { _ in emojis.randomElement()! }
        options.append(targetEmoji) // Ajoute l'emoji cible aux options
        options.shuffle() // Mélange les options
    }
    
    func checkGuess(_ guessedEmoji: String) {
        if guessedEmoji == targetEmoji {
            resultMessage = "Correct ! 🎉"
            score += 1
        } else {
            resultMessage = "Incorrect. 😢"
            score -= 1
        }
        
        if score < -2 {
            gameOver = true
        } else {
            generateNewRound()
        }
    }
    
    func resetGame() {
        startGame()
    }
    
    func getEmojiDescription(for emoji: String) -> String {
        switch emoji {
        case "😀": return "un visage souriant"
        case "😂": return "un visage riant aux larmes"
        case "🥳": return "un visage de fête"
        case "😎": return "un visage avec des lunettes de soleil"
        case "😍": return "un visage avec des cœurs dans les yeux"
        case "🤔": return "un visage pensif"
        case "🤩": return "un visage émerveillé"
        case "😢": return "un visage en pleurs"
        case "😡": return "un visage en colère"
        default: return "un emoji"
        }
    }
}
