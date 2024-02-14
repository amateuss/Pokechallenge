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
    var imageData: Data?
}
