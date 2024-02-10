//
//  PokemonGatewayTests.swift
//  PokechallengeTests
//
//  Created by André Silva on 10/02/2024.
//

import XCTest
@testable import Pokechallenge

class PokeAPIServiceTests: XCTestCase {
    var sut: PokemonGateway!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = PokemonGatewayImpl(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    // MARK: - fetchAllPokemon Tests
    func testFetchAllPokemon_Success() {
        // Given
        let responseData = """
            {
                "results": [
                    {
                        "name": "bulbasaur",
                        "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    },
                    {
                        "name": "charmander",
                        "url": "https://pokeapi.co/api/v2/pokemon/4/"
                    }
                ]
            }
            """.data(using: .utf8)!
        mockNetworkService.result = .success(responseData)
        
        // When
        var capturedResult: Result<[PokemonListItem], Error>?
        sut.fetchAllPokemon { result in
            capturedResult = result
        }
        
        // Then
        XCTAssertTrue(mockNetworkService.requestDataCalled)
        XCTAssertEqual(mockNetworkService.requestURL, URL(string: "https://pokeapi.co/api/v2/pokemon")!)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success(let pokemonList):
            XCTAssertEqual(pokemonList.count, 2)
            XCTAssertEqual(pokemonList[0].name, "bulbasaur")
            XCTAssertEqual(pokemonList[1].name, "charmander")
        case .failure:
            XCTFail("Unexpected failure")
        case .none:
            XCTFail("Result was nil")
        }
    }
    
    func testFetchAllPokemon_Failure() {
        // Given
        mockNetworkService.result = .failure(NetworkError.invalidResponse)
        
        // When
        var capturedResult: Result<[PokemonListItem], Error>?
        sut.fetchAllPokemon { result in
            capturedResult = result
        }
        
        // Then
        XCTAssertTrue(mockNetworkService.requestDataCalled)
        XCTAssertEqual(mockNetworkService.requestURL, URL(string: "https://pokeapi.co/api/v2/pokemon")!)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let error):
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        case .none:
            XCTFail("Result was nil")
        }
    }
    
    // MARK: - fetchPokemon Tests
    
    func testFetchPokemon_Success() {
        // Given
        let responseData = """
            {
                "name": "pikachu",
                "abilities": [
                    {
                        "ability": {
                            "name": "static"
                        }
                    },
                    {
                        "ability": {
                            "name": "lightning-rod"
                        }
                    }
                ]
            }
            """.data(using: .utf8)!
        mockNetworkService.result = .success(responseData)
        
        // When
        var capturedResult: Result<Pokemon, Error>?
        sut.fetchPokemon(name: "pikachu") { result in
            capturedResult = result
        }
        
        // Then
        XCTAssertTrue(mockNetworkService.requestDataCalled)
        XCTAssertEqual(mockNetworkService.requestURL, URL(string: "https://pokeapi.co/api/v2/pokemon/pikachu")!)
        XCTAssertNotNil(capturedResult)
        
        switch capturedResult {
        case .success(let pokemon):
            XCTAssertEqual(pokemon.name, "pikachu")
            XCTAssertEqual(pokemon.abilities.count, 2)
            XCTAssertEqual(pokemon.abilities[0].ability.name, "static")
            XCTAssertEqual(pokemon.abilities[1].ability.name, "lightning-rod")
        case .failure:
            XCTFail("Unexpected failure")
        case .none:
            XCTFail("Result was nil")
        }
    }
    
    func testFetchPokemon_Failure() {
        // Given
        mockNetworkService.result = .failure(NetworkError.noData)
        
        // When
        var capturedResult: Result<Pokemon, Error>?
        sut.fetchPokemon(name: "invalidPokemon") { result in
            capturedResult = result
        }
        
        
        // Then
        XCTAssertTrue(mockNetworkService.requestDataCalled)
        XCTAssertEqual(mockNetworkService.requestURL, URL(string: "https://pokeapi.co/api/v2/pokemon/invalidpokemon")!)
        XCTAssertNotNil(capturedResult)
        
        switch capturedResult {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let error):
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, NetworkError.noData)
        case .none:
            XCTFail("Result was nil")
        }
    }
}

