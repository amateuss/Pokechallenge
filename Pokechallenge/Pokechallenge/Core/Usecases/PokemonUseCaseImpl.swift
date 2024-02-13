//
//  PokemonUseCase.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

protocol PokemonUseCase {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItemModel]>)
    func fetchPokemon(name: String, completion: @escaping CompletionHandler<PokemonModel>)
}

final class PokemonUseCaseImpl: PokemonUseCase {
    private let pokemonGateway: PokemonGateway
    private let loggerSystem: LoggerSystem
    
    init(pokemonGateway: PokemonGateway, loggerSystem: LoggerSystem = LoggerSystemImpl()) {
        self.pokemonGateway = pokemonGateway
        self.loggerSystem = loggerSystem
    }
    
    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItemModel]>) {
        pokemonGateway.fetchAllPokemon { result in
            var pokemonListModel: [PokemonListItemModel] = []
            
            switch result {
            case .success(let pokemonListItemEntity):
                for entity in pokemonListItemEntity {
                    let model = PokemonListItemModel(name: entity.name, url: entity.url)
                    pokemonListModel.append(model)
                }

                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: "Fetch Pokemon Sucsess: \n \(pokemonListModel)", error: nil)
                
                completion(.success(pokemonListModel))
                
            case .failure(let error):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonError.operationFailed.description)
                completion(.failure(PokemonError.operationFailed))
            }
        }
    }
    
    func fetchPokemon(name: String, completion: @escaping CompletionHandler<PokemonModel>) {
        pokemonGateway.fetchPokemon(name: name) { result in
            switch result {
            case .success(let pokemonEntity):
                let pokemonModel = PokemonModel(name: pokemonEntity.name, 
                                                height: pokemonEntity.height,
                                                weight: pokemonEntity.weight,
                                                imageURL: pokemonEntity.sprites.frontDefault)
                
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: "Fetch Pokemon Sucsess: \n \(pokemonModel)", error: nil)
                
                completion(.success(pokemonModel))
            case .failure(let error):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonError.operationFailed.description)
                completion(.failure(PokemonError.operationFailed))
            }
        }
    }
}
