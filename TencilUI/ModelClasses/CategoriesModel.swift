//
//  CategoriesModel.swift
//  TencilUI
//
//  Created by Manu Puthoor on 26/06/21.
//

import Foundation

// MARK: - CategoriesModel
struct CategoriesModel: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let id = UUID()
    let cid, name: String?
}
