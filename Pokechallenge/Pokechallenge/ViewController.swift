//
//  ViewController.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkServiceImpl()
        let pokeAPIGateway = PokemonGatewayImpl(networkService: networkService)
        let pokemonUseCase = PokemonUseCaseImpl(pokemonGateway: pokeAPIGateway)

//        pokeAPIService.fetchAllPokemon { result in
//            switch result {
//            case .success(let pokemonList):
//                for pokemonItem in pokemonList {
//                    print("Pokemon name: \(pokemonItem.name)")
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
        
        let pokemonName = "ditto"
        pokeAPIGateway.fetchPokemon(name: pokemonName) { result in

            switch result {
            case .success(let pokemon):
                print("Pokemon name: \(pokemon)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
//        pokemonUseCase.fetchAllPokemon { result in
//            switch result {
//            case .success(let pokemonList):
//                for pokemonItem in pokemonList {
//                    print("Pokemon name: \(pokemonItem.name)")
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
        
//        pokemonUseCase.fetchPokemon(name: pokemonName) { result in
//            switch result {
//            case .success(let pokemon):
//                print("Pokemon name: \(pokemon)")
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
    }


}

