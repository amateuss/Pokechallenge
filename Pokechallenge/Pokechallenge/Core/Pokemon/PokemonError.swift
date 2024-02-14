//
//  PokemonError.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

enum PokemonError: Error {
    case operationFailed
    case decodingError

    var description: String {
        switch self {
        case .operationFailed: return "Operation Failed"
        case .decodingError: return "Key not found"
        }
    }
}
