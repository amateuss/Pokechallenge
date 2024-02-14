//
//  PokemonListAssembly.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

final class PokemonListAssembly {
        
    static func pokemonListViewController() -> PokemonListViewController {
        let networkService = NetworkServiceImpl()
        let pokeAPIGateway = PokemonGatewayImpl(networkService: networkService)
        let pokemonUseCase = PokemonUseCaseImpl(pokemonGateway: pokeAPIGateway)
        
        let presenter = PokemonListPresenter(pokemonUseCase: pokemonUseCase)
        let router = PokemonListRouterImp()
        presenter.router = router
        let viewController = PokemonListViewController(presenter: presenter)
        router.view = viewController
        
        return viewController
    }
}
