//
//  JackpotView.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 16/10/2024.
//

import SwiftUI

struct JackpotView: View {
    
    @State private var slot1 = 0
    @State private var slot2 = 0
    @State private var slot3 = 0
    @State private var resultMessage = "Clique sur Jouer"
    @State private var isSpinning = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.orange.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                HStack(spacing: 30) {
                    SlotView(number: $slot1, isSpinning: $isSpinning)
                    SlotView(number: $slot2, isSpinning: $isSpinning)
                    SlotView(number: $slot3, isSpinning: $isSpinning)
                }
                .padding()
                
           
                Text(resultMessage)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                
                Button(action: {
                    jouer()
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
    
    func jouer() {
        isSpinning = true
        
        withAnimation(Animation.linear(duration: 2)) {
            spinSlots()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSpinning = false
            finalResult()
        }
    }
    
    func spinSlots() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            slot1 = Int.random(in: 0...9)
            slot2 = Int.random(in: 0...9)
            slot3 = Int.random(in: 0...9)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                timer.invalidate()
            }
        }
    }
    
    func finalResult() {
        if slot1 == 7 && slot2 == 7 && slot3 == 7 {
            resultMessage = "Winner 🎉"
        } else {
            slot1 = Int.random(in: 0...9)
            slot2 = Int.random(in: 0...9)
            slot3 = Int.random(in: 0...9)
            resultMessage = "Mince, essaye encore"
        }
    }
}

struct SlotView: View {
    @Binding var number: Int
    @Binding var isSpinning: Bool
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 64, weight: .bold))
                .padding()
                .frame(width: 100, height: 100)
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .offset(y: isSpinning ? -20 : 0)
                .animation(isSpinning ? Animation.linear(duration: 0.1).repeatForever(autoreverses: false) : .default, value: isSpinning)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
