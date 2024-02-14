//
//  PokemonDetailsAssembly.swift
//  Pokechallenge
//
//  Created by André Silva on 14/02/2024.
//

import Foundation

final class PokemonDetailsAssembly {
    private let networkService: NetworkService
    private let pokeAPIGateway: PokemonGateway
    
    init(networkService: NetworkService, pokeAPIGateway: PokemonGateway) {
        self.networkService = networkService
        self.pokeAPIGateway = pokeAPIGateway
    }
    
    static func pokemonDetailsPresenter(useCase: PokemonUseCase) -> PokemonDetailsPresenter {
        return PokemonDetailsPresenter(pokemonUseCase: useCase)
    }
    
    static func pokemonDetailsViewController(presenter: PokemonDetailsPresenter) -> PokemonDetailsViewController {
        return PokemonDetailsViewController(presenter: presenter)
    }
}
