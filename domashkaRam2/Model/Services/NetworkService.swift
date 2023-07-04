//
//  NetworkService.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import Foundation

enum RickAndMortyError: Error {
    case UFO
}

struct NetworkService {
    
    static let shared = NetworkService()
    
    func fetchCharacters() async throws -> Characters {
        let request = URLRequest(url: Constants.API.baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
