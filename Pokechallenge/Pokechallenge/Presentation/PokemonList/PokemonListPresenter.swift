//
//  PokemonListPresenter.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

protocol PresenterProtocol {
    var view: ViewProtocol? { get set }
    var viewModel: PokemonListViewModel? { get set }
    func getPokemons()
    func fetchPokemon(by name: String, index: Int)
}

protocol ViewProtocol: AnyObject {
    func showAlertWith(title: String, message: String, actions: NSArray?)
    func updateView(with pokemonItem: PokemonListItemViewModel, indexPath: Int)
    func reloadData()
}

class PokemonListPresenter: PresenterProtocol {
    
    private let loggerSystem: LoggerSystem
    
    private let pokemonUseCase: PokemonUseCase
    var viewModel: PokemonListViewModel?
    var view: ViewProtocol?
    
    init(pokemonUseCase: PokemonUseCase, loggerSystem: LoggerSystem = LoggerSystemImpl()) {
        self.pokemonUseCase = pokemonUseCase
        self.loggerSystem = loggerSystem
    }
    
    func getPokemons() {
        if viewModel != nil {
            self.view?.reloadData()
        } else {
            fetchPokemons()
        }
    }
    
    private func fetchPokemons() {
        pokemonUseCase.fetchAllPokemon { result in
            var pokemonListItemViewModel: [PokemonListItemViewModel] = []
            
            switch result {
            case .success(let pokemonListItemModel):
    
                for model in pokemonListItemModel {
                    let viewModel = PokemonListItemViewModel(name: model.name, imageData: nil)
                    pokemonListItemViewModel.append(viewModel)
                }
                
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: "Fetch Pokemon Sucsess: \n \(pokemonListItemViewModel)", error: nil)
                
                DispatchQueue.main.async {
                    self.viewModel = PokemonListViewModel(pokemonListItemViewModel: pokemonListItemViewModel)
                    self.view?.reloadData()
                }

            case .failure(let error):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonError.operationFailed.description)
                
                DispatchQueue.main.async {
                    self.view?.showAlertWith(title: Constants.alertTitle, message: Constants.alertMessage, actions: nil)
                }
            }
        }
    }
    func fetchPokemon(by name: String, index: Int) {
        pokemonUseCase.fetchPokemon(name: name) { result in
            
            switch result {
                
            case .success(let pokemonModel):
                guard var pokemon = self.viewModel?.pokemonListItemViewModel[index] else {
                    return
                }
                guard let url = URL(string: pokemonModel.imageURL) else {
                    return
                }
                
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                
                pokemon.imageData = data
                
                self.viewModel?.pokemonListItemViewModel[index] = pokemon
                
                DispatchQueue.main.async {
                    self.view?.updateView(with: pokemon, indexPath: index)
                }
            case .failure(_):
                self.loggerSystem.logger(info: "File: \(#fileID):\(#line) --> func: \(#function)", message: nil, error: PokemonError.operationFailed.description)
            }
        }
        
    }
}

// MARK: - Constants
private extension PokemonListPresenter {
    enum Constants {
        static let alertTitle = "No data"
        static let alertMessage = "It was not possible to get the information"
    }
}