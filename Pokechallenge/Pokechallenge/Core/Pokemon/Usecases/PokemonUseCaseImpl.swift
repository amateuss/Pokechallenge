//
//  PokemonUseCase.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

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
                self.loggerSystem.logger(type: .success, message: "Fetched Pokemon List: \n \(pokemonListModel)", info: nil)
                
                completion(.success(pokemonListModel))
                
            case .failure(let error):
                guard let errorType = error as? PokemonGatewayError else {
                    self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    return
                }
                
                switch errorType {
                case .operationFailed:
                    self.loggerSystem.logger(type: .error, message: PokemonError.operationFailed.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(PokemonError.operationFailed))
                case .decodingError:
                    self.loggerSystem.logger(type: .error, message: PokemonError.decodingError.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(PokemonError.decodingError))
                }
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
                
                self.loggerSystem.logger(type: .success, message: "Fetched Pokemon: \n \(pokemonModel)", info: nil)
                completion(.success(pokemonModel))
                
            case .failure(let error):
                guard let errorType = error as? PokemonGatewayError else {
                    self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    return
                }
                
                switch errorType {
                case .operationFailed:
                    self.loggerSystem.logger(type: .error, message: PokemonError.operationFailed.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(PokemonError.operationFailed))
                case .decodingError:
                    self.loggerSystem.logger(type: .error, message: PokemonError.decodingError.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    completion(.failure(PokemonError.decodingError))
                }
            }
        }
    }
}
