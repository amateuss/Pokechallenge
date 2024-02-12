//
//  PokemonEntity.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

// MARK: - Entities
struct PokemonListResponseEntity: Codable {
    let results: [PokemonListItemEntity]
}

struct PokemonListItemEntity: Codable {
    let name: String
    let url: String
}

struct PokemonEntity: Codable {
    let name: String
    let height: Int
    let weight: Int
}


