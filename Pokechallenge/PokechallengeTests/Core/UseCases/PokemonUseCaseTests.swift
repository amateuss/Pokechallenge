//
//  PokemonUseCaseTests.swift
//  PokechallengeTests
//
//  Created by André Silva on 12/02/2024.
//

import XCTest
@testable import Pokechallenge

class PokemonUseCaseImplTests: XCTestCase {
    var sut: PokemonUseCaseImpl!
    var mockPokemonGateway: MockPokemonGateway!

    override func setUp() {
        super.setUp()
        mockPokemonGateway = MockPokemonGateway()
        sut = PokemonUseCaseImpl(pokemonGateway: mockPokemonGateway)
    }

    override func tearDown() {
        sut = nil
        mockPokemonGateway = nil
        super.tearDown()
    }

    // MARK: - fetchAllPokemon Tests

    func testFetchAllPokemon_Success() {
        // Given
        let pokemonListItemEntities: [PokemonListItemEntity] = [
            PokemonListItemEntity(name: "bulbasaur", url: "https://foo.com/v2/pokemon/1/"),
            PokemonListItemEntity(name: "charmander", url: "https://foo.com/v2/pokemon/4/")
        ]
        mockPokemonGateway.fetchAllPokemonResult = .success(pokemonListItemEntities)

        // When
        var capturedResult: Result<[PokemonListItemModel], Error>?
        sut.fetchAllPokemon { result in
            capturedResult = result
        }

        // Then
        XCTAssertTrue(mockPokemonGateway.fetchAllPokemonCalled)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success(let pokemonModelList):
            XCTAssertEqual(pokemonModelList.count, 2)
            XCTAssertEqual(pokemonModelList[0].name, "bulbasaur")
            XCTAssertEqual(pokemonModelList[1].name, "charmander")
        case .failure:
            XCTFail("Unexpected failure")
        case .none:
            XCTFail("Result was nil")
        }
    }

    func testFetchAllPokemon_Failure() {
        // Given
        mockPokemonGateway.fetchAllPokemonResult = .failure(PokemonError.operationFailed)

        // When
        var capturedResult: Result<[PokemonListItemModel], Error>?
        sut.fetchAllPokemon { result in
            capturedResult = result
        }

        // Then
        XCTAssertTrue(mockPokemonGateway.fetchAllPokemonCalled)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let error):
            XCTAssertTrue(error is PokemonError)
            XCTAssertEqual(error as? PokemonError, PokemonError.operationFailed)
        case .none:
            XCTFail("Result was nil")
        }
    }

    // MARK: - fetchPokemon Tests

    func testFetchPokemon_Success() {
        // Given
        let pokemonEntity = PokemonEntity(name: "pikachu", height: 40, weight: 60)
        mockPokemonGateway.fetchPokemonResult = .success(pokemonEntity)

        // When
        var capturedResult: Result<PokemonModel, Error>?
        sut.fetchPokemon(name: "pikachu") { result in
            capturedResult = result
        }

        // Then
        XCTAssertTrue(mockPokemonGateway.fetchPokemonCalled)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success(let pokemonModel):
            XCTAssertEqual(pokemonModel.name, "pikachu")
            XCTAssertEqual(pokemonModel.height, 40)
            XCTAssertEqual(pokemonModel.weight, 60)
        case .failure:
            XCTFail("Unexpected failure")
        case .none:
            XCTFail("Result was nil")
        }
    }

    func testFetchPokemon_Failure() {
        // Given
        mockPokemonGateway.fetchPokemonResult = .failure(PokemonError.operationFailed)

        // When
        var capturedResult: Result<PokemonModel, Error>?
        sut.fetchPokemon(name: "invalidPokemon") { result in
            capturedResult = result
        }

        // Then
        XCTAssertTrue(mockPokemonGateway.fetchPokemonCalled)
        XCTAssertNotNil(capturedResult)
        switch capturedResult {
        case .success:
            XCTFail("Unexpected success")
        case .failure(let error):
            XCTAssertTrue(error is PokemonError)
            XCTAssertEqual(error as? PokemonError, PokemonError.operationFailed)
        case .none:
            XCTFail("Result was nil")
        }
    }
}
