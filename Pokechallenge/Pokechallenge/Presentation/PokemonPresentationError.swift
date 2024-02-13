//
//  PokemonPresentationError.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

enum PokemonViewError: Error {
    case noData

    var description: String {
        switch self {
        case .noData: return "No Data"
        }
    }
}
