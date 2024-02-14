//
//  PokemonGateway.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import Foundation

final class PokemonGatewayImpl: PokemonGateway {
    private let networkService: NetworkService
    private let loggerSystem: LoggerSystem
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    init(networkService: NetworkService, loggerSystem: LoggerSystem = LoggerSystemImpl()) {
        self.networkService = networkService
        self.loggerSystem = loggerSystem
    }
    
    func fetchAllPokemon(completion: @escaping (Result<[PokemonListItemEntity], Error>) -> Void) {
        networkService.requestData(from: baseURL) { result in
            switch result {
            case .success(let data):
                do {
                    let pokemonListResponse = try JSONDecoder().decode(PokemonListResponseEntity.self, from: data)
                    
                    self.loggerSystem.logger(type: .success, message: "Fetched Pokemon List: \n \(pokemonListResponse)", info: nil)
                    completion(.success(pokemonListResponse.results))
                } catch {
                    self.loggerSystem.logger(type: .error, message: PokemonGatewayError.decodingError.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(error))
                }
            case .failure(let error):
                guard let errorType = error as? NetworkError else {
                    self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    return
                }
                
                switch errorType {
                case .invalidURL:
                    self.loggerSystem.logger(type: .error, message: NetworkError.invalidURL.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.invalidURL))
                case .invalidResponse:
                    self.loggerSystem.logger(type: .error, message: NetworkError.invalidResponse.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.invalidResponse))
                case .noData:
                    self.loggerSystem.logger(type: .error, message: NetworkError.noData.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.noData))
                }
            }
        }
    }
    
    func fetchPokemon(name: String, completion: @escaping (Result<PokemonEntity, Error>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent(name.lowercased())

        networkService.requestData(from: pokemonURL) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(PokemonEntity.self, from: data)
                    
                    self.loggerSystem.logger(type: .success, message: "Fetched Pokemon : \n \(pokemon)", info: nil)
                    completion(.success(pokemon))
                } catch {
                    self.loggerSystem.logger(type: .error, message: PokemonGatewayError.decodingError.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(PokemonGatewayError.decodingError))
                }
            case .failure(let error):
                guard let errorType = error as? NetworkError else {
                    self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    return
                }
                
                switch errorType {
                case .invalidURL:
                    self.loggerSystem.logger(type: .error, message: NetworkError.invalidURL.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.invalidURL))
                case .invalidResponse:
                    self.loggerSystem.logger(type: .error, message: NetworkError.invalidResponse.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.invalidResponse))
                case .noData:
                    self.loggerSystem.logger(type: .error, message: NetworkError.noData.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(NetworkError.noData))
                }
            }
        }
    }
}

enum PokemonGatewayError: Error {
    case operationFailed
    case decodingError

    var description: String {
        switch self {
        case .operationFailed: return "Operation Failed"
        case .decodingError: return "Key not found"
        }
    }
}


