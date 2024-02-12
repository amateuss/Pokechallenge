//
//  PokemonEntity.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

// MARK: - Entities
struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct Pokemon: Codable {
    let name: String
    let height: Int
    let weight: Int
}


