//
//  AppDetailView.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 16/10/2024.
//

import SwiftUI

struct AppDetailView: View {
    var appName: String

    var body: some View {
        VStack {
            Text(appName)
                .font(.largeTitle)
                .padding()
            
            if appName == AvailableApps.jackpot.rawValue {
                JackpotView()
            }
            if appName == AvailableApps.pierreFeuilleCiseaux.rawValue {
                PierreFeuilleCiseauxView()
            }
            if appName == AvailableApps.devinezLeNombreView.rawValue {
                DevinezLeNombreView()
            }
            else {
                Text("Détails de l'application \(appName)")
                    .font(.subheadline)
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle(appName, displayMode: .inline)
        .padding()
    }
}

#Preview {
    AppDetailView(appName: "Exemple d'application")
}
