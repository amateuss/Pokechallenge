//
//  PokemonGateway.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import Foundation

protocol PokemonGateway {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItem]>)
    func fetchPokemon(name: String, completion: @escaping CompletionHandler<Pokemon>)
}

class PokemonGatewayImpl: PokemonGateway {
    private let networkService: NetworkService
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAllPokemon(completion: @escaping (Result<[PokemonListItem], Error>) -> Void) {
        networkService.requestData(from: baseURL) { result in
            switch result {
            case .success(let data):
                do {
                    let pokemonListResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    completion(.success(pokemonListResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent(name.lowercased())

        networkService.requestData(from: pokemonURL) { result in
            switch result {
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Models
struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct Pokemon: Codable {
    let name: String
    let abilities: [Ability]
}

struct Ability: Codable {
    let ability: AbilityInfo
}

struct AbilityInfo: Codable {
    let name: String
}
