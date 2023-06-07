//
//  Model.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/26/23.
//

import Foundation

// MARK: - Product
struct Products: Codable {
    let products: [Product]
    let total,
        skip,
        limit: Int
}

// MARK: - ProductElement
struct Product: Codable {
    let id: Int
    let title,
        description: String
    let price: Int
    let rating: Double
    let category: String
    let thumbnail: String
}
