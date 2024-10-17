//
//  AppListView.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 15/10/2024.
//

import SwiftUI

struct MenuAppView: View {
    let apps = AvailableApps.allCases

    var body: some View {
        VStack {
            Text("Jeux Disponibles")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 10)
                .foregroundColor(.black)
                .foregroundColor(AppParameters.backgroundColor)

            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(apps, id: \.self) { app in
                        NavigationLink(destination: AppDetailView(appName: app.rawValue)) {
                            AppCardView(appName: app.rawValue, imageName: app.imageName)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("")
    }
}

#Preview {
    MenuAppView()
}
