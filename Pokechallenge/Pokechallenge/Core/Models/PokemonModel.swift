//
//  PokemonModel.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

//struct PokemonModelList: Codable {
//    let pokemonModelListItem: [PokemonModelListItem]
//    
//    init(pokemonModelListItem: [PokemonModelListItem]) {
//        self.pokemonModelListItem = pokemonModelListItem
//    }
//}

struct PokemonModelListItem: Codable {
    let name: String
    let url: String
}

struct PokemonModel: Codable {
    let name: String
    let height: Int
    let weight: Int
}
