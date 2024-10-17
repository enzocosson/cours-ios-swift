import SwiftUI

struct JackpotView: View {
    @StateObject private var jackpotModel = JackpotModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.orange.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                HStack(spacing: 30) {
                    ForEach(0..<jackpotModel.slots.count, id: \.self) { index in
                        Text("\(jackpotModel.slots[index])")
                            .font(.system(size: 64, weight: .bold))
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                            .offset(y: jackpotModel.isSpinning ? -20 : 0)
                            .animation(jackpotModel.isSpinning ? Animation.linear(duration: 0.1).repeatForever(autoreverses: false) : .default, value: jackpotModel.isSpinning)
                    }
                }
                .padding()
                
                Text(jackpotModel.resultMessage)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Button(action: {
                    jackpotModel.jouer()
                }) {
                    Text("Jouer")
                        .font(.system(size: 26, weight: .bold))
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                }
                .padding(.bottom, 20)
            }
        }
    }
}
