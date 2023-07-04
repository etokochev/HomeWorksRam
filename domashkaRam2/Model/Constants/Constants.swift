//
//  Constants.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import Foundation

enum Constants {
    
    enum API {
        static let baseURL = URL(string: "https://rickandmortyapi.com/api/character")!
    }
    
    enum Keychain {
        static let service = "PhoneAuth"
        static let account = "phoneSigin"
    }
}
