//
//  PokemonModel.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

struct PokemonListItemModel: Codable {
    let name: String
    let url: String
}

struct PokemonModel: Codable {
    let name: String
    let height: Int
    let weight: Int
    let imageURL: String
    
//    struct Sprites: Codable {
//        let frontDefault: String
//        
//        enum CodingKeys: String, CodingKey {
//            case frontDefault = "front_default"
//        }
//    }
}
