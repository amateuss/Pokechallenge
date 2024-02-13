//
//  PokemonViewModel.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

struct PokemonViewModel: Codable {
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
