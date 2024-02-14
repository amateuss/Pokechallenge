//
//  PokemonListRouter.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

protocol PokemonListRouter {
    var view: PokemonListViewController? { get set }
    func natigateToPokemonDetails(pokeDTO: PokeDTO, usecase: PokemonUseCase)
}

final class PokemonListRouterImp: PokemonListRouter {
    weak var view: PokemonListViewController?
    
    func natigateToPokemonDetails(pokeDTO: PokeDTO, usecase: PokemonUseCase) {
        let presenter = PokemonDetailsAssembly.pokemonDetailsPresenter(useCase: usecase)
        presenter.pokeDto = pokeDTO
        
        let viewController = PokemonDetailsAssembly.pokemonDetailsViewController(presenter: presenter)
        
        if let navigationController = self.view?.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
