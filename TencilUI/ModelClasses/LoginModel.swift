//
//  LoginModel.swift
//  TencilUI
//
//  Created by Manu Puthoor on 25/06/21.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable , Identifiable {
    let id = UUID()
    let uid, fname: String
    let passwordMatches: Bool
    let userAPIKey: String
    let userActive: Bool

    enum CodingKeys: String, CodingKey {
        case uid, fname, passwordMatches
        case userAPIKey = "userApiKey"
        case userActive
    }
}
