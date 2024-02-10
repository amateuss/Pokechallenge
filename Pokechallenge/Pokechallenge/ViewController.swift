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
        // Do any additional setup after loading the view.
        
        let networkService = NetworkServiceImpl()
        let pokeAPIService = PokemonGatewayImpl(networkService: networkService)

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
        
        let pokemonName = "ditto" // Set the name of the Pokemon you want to fetch
        pokeAPIService.fetchPokemon(name: pokemonName) { result in
            
            switch result {
            case .success(let pokemon):
                print("Pokemon name: \(pokemon)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }


}

