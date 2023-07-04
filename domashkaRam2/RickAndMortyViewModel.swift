//
//  RickAndMortyViewModel.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import Foundation

class RickAndMortyViewModel {
    private let networkService = NetworkService()
    
    func fetchCharacters() async throws -> Characters {
        try await networkService.fetchCharacters()
    }
}
