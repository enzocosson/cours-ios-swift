import SwiftUI

class JackpotModel: ObservableObject {
    @Published var slots: [Int] = [0, 0, 0]
    @Published var resultMessage = "Clique sur Jouer"
    @Published var isSpinning = false

    func jouer() {
        isSpinning = true
        
        withAnimation(Animation.linear(duration: 2)) {
            spinSlots()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSpinning = false
            self.finalResult()
        }
    }
    
    private func spinSlots() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            for index in 0..<self.slots.count {
                self.slots[index] = Int.random(in: 0...9)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                timer.invalidate()
            }
        }
    }
    
    private func finalResult() {
        if slots.allSatisfy({ $0 == 7 }) {
            resultMessage = "Winner 🎉"
        } else {
            resultMessage = "Mince, essaye encore"
        }
    }
}
