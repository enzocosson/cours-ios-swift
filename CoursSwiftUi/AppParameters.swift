//
//  AppParameters.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 16/10/2024.
//

import SwiftUI

class AppParameters {
    static let backgroundColor: Color = .orange
    static var isValid: Bool = false
}

enum AvailableApps: String, CaseIterable {
    case jackpot = "Jackpot"
    case pierreFeuilleCiseaux = "Pierre Feuille Ciseaux"
    case devinezLeNombreView = "Devinez Le Nombre"
    case emoji = "Emoji"
    case echec = "Echec"
    
    var imageName: String {
        switch self {
        case .jackpot:
            return "jackpot"
        case .pierreFeuilleCiseaux:
            return "pierreFeuilleCiseaux"
        case .devinezLeNombreView:
            return "nombre"
        case .emoji:
            return "emoji"
        case .echec:
            return "echec"
        }
    }
}
