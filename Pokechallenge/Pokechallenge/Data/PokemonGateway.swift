//
//  PokemonGateway.swift
//  Pokechallenge
//
//  Created by André Silva on 12/02/2024.
//

import Foundation

protocol PokemonGateway {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItem]>)
    func fetchPokemon(name: String, completion: @escaping CompletionHandler<Pokemon>)
}
