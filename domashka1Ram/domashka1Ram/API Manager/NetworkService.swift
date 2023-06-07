//
//  NetworkService.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/26/23.
//

import Foundation

class NetworkService {
     private let baseURL = URL(
        string: "https://dummyjson.com/products")!
    
    func productRequest(completion:
                                @escaping(Result<Products, Error>) -> Void) {
        let request = URLRequest(url: baseURL)
        
        URLSession(configuration: .default)
            .dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data {
                do {
                    let model: Products = try self.decode(data: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    func productRequest() async throws -> Products {
        let request = URLRequest(url: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
