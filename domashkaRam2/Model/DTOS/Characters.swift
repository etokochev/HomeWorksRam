//
//  Characters.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import Foundation

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}
