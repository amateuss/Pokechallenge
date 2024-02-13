//
//  PokemonListViewModel.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

struct PokemonListViewModel: Codable {
    let pokemonListItemViewModel: [PokemonListItemViewModel]

    init(pokemonListItemViewModel: [PokemonListItemViewModel]) {
        self.pokemonListItemViewModel = pokemonListItemViewModel
    }
}

struct PokemonListItemViewModel: Codable {
    let name: String
    let url: String
}
