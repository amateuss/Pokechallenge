//
//  PokemonDetailsPresenter.swift
//  Pokechallenge
//
//  Created by André Silva on 14/02/2024.
//

import Foundation

protocol PokemonDetailsPresenterProtocol {
    var view: PokemonDetailsViewProtocol? { get set }
    var pokeDto: PokeDTO? { get }
    var viewModel: PokemonViewModel? { get set }
    func fetchPokemon(by name: String)
}

protocol PokemonDetailsViewProtocol: AnyObject {
    func showAlertWith(title: String, message: String, actions: NSArray?)
}

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
    private let loggerSystem: LoggerSystem
    
    private let pokemonUseCase: PokemonUseCase
    var viewModel: PokemonViewModel?
    weak var view: PokemonDetailsViewProtocol?
    
    var pokeDto: PokeDTO?
    
    init(pokemonUseCase: PokemonUseCase, loggerSystem: LoggerSystem = LoggerSystemImpl()) {
        self.pokemonUseCase = pokemonUseCase
        self.loggerSystem = loggerSystem
    }

    func fetchPokemon(by name: String) {
        pokemonUseCase.fetchPokemon(name: name) { result in
            
            switch result {
            case .success(let pokemonModel):
                var pokemonDetailViewModel = PokemonViewModel(name: pokemonModel.name, height: pokemonModel.height, weight: pokemonModel.weight, imageData: nil)
                
                if let imageData = self.pokeDto?.imageData {
                    pokemonDetailViewModel.imageData = imageData
                }
                
                DispatchQueue.main.async {
                    self.viewModel = pokemonDetailViewModel
                }
            case .failure(let error):
                guard let errorType = error as? PokemonError else {
                    self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                    return
                }
                
                switch errorType {
                case .operationFailed, .decodingError:
                    DispatchQueue.main.async {
                        self.view?.showAlertWith(title: Constants.alertTitle, message: Constants.alertMessage, actions: nil)
                    }
                    self.loggerSystem.logger(type: .error, message: errorType.description, info: "File: \(#fileID):\(#line) --> func: \(#function)")
                }
            }
        }
    }
}

// MARK: - Constants
private extension PokemonDetailsPresenter {
    enum Constants {
        static let alertTitle = "No data"
        static let alertMessage = "It was not possible to get the information"
    }
}
