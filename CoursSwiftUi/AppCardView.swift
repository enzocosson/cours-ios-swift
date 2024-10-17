//
//  AppCardView.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 16/10/2024.
//

import SwiftUI

struct AppCardView: View {
    var appName: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { geometry in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    )
            }
            .frame(width: 320, height: 180)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)

            Text(appName)
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding([.leading, .bottom], 20)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
        }
        .frame(width: 320, height: 180)
        .background(Color.white.opacity(0.1))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        .padding()
    }
}
