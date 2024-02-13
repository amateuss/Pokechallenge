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
                    self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: "Fetch Pokemon Sucsess: \n \(pokemonListResponse)", error: nil)
                    completion(.success(pokemonListResponse.results))
                } catch {
                    self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonGatewayError.decodingError.description)
                    completion(.failure(error))
                }
            case .failure(let error):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonGatewayError.operationFailed.description)
                completion(.failure(error))
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
                    
                    self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: "Fetch Pokemon Sucsess: \n \(pokemon)", error: nil)
                    
                    completion(.success(pokemon))
                } catch {
                    self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonGatewayError.decodingError.description)
                    
                    completion(.failure(PokemonGatewayError.decodingError))
                }
            case .failure(let error):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonGatewayError.operationFailed.description)
                
                completion(.failure(error))
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


