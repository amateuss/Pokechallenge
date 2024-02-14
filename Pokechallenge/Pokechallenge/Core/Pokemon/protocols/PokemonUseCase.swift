//
//  PokemonUseCase.swift
//  Pokechallenge
//
//  Created by André Silva on 14/02/2024.
//

import Foundation

protocol PokemonUseCase {
    typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void
    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItemModel]>)
    func fetchPokemon(name: String, completion: @escaping CompletionHandler<PokemonModel>)
}
