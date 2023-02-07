//
//  NetworkManager.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<Coin, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let coin = try decoder.decode(Coin.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(coin))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
}

extension NetworkManager {
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
