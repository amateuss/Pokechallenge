//
//  MockPokemonGateway.swift
//  PokechallengeTests
//
//  Created by André Silva on 12/02/2024.
//

import Foundation
@testable import Pokechallenge

class MockPokemonGateway: PokemonGateway {
    var fetchAllPokemonCalled = false
    var fetchPokemonCalled = false
    var fetchAllPokemonResult: Result<[PokemonListItemEntity], Error>?
    var fetchPokemonResult: Result<PokemonEntity, Error>?

    func fetchAllPokemon(completion: @escaping CompletionHandler<[PokemonListItemEntity]>) {
        fetchAllPokemonCalled = true
        if let result = fetchAllPokemonResult {
            completion(result)
        }
    }

    func fetchPokemon(name: String, completion: @escaping CompletionHandler<PokemonEntity>) {
        fetchPokemonCalled = true
        if let result = fetchPokemonResult {
            completion(result)
        }
    }
}
