//
//  PokemonListViewModel.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

struct PokemonListViewModel: Codable {
    var pokemonListItemViewModel: [PokemonListItemViewModel]

    init(pokemonListItemViewModel: [PokemonListItemViewModel]) {
        self.pokemonListItemViewModel = pokemonListItemViewModel
    }
}

struct PokemonListItemViewModel: Codable {
    let name: String
    var imageData: Data?
}
