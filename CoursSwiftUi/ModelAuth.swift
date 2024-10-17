//
//  ModelAuth.swift
//  CoursSwiftUi
//
//  Created by Enzo Cosson on 15/10/2024.
//

import Foundation
import Combine

class DataController {
    static let registeredUsers: [String: String] = [
        "admin": "password",
        "user1": "pass123",
        "user2": "qwerty"
    ]
}

class ModelAuth: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isValid: Bool = false  

    func checkCredentials() {
        if let realPassword = DataController.registeredUsers[username] {
            if realPassword == password {
                isValid = true
            } else {
                isValid = false
            }
        } else {
            isValid = false
        }
    }
}
