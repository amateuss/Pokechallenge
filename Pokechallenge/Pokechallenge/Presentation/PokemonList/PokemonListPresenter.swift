//
//  PokemonListPresenter.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation

protocol PokemonListPresenterProtocol {
    var view: PokemonListViewProtocol? { get set }
    var router: PokemonListRouter? { get set }
    var viewModel: PokemonListViewModel? { get set }
    func getPokemons()
    func fetchPokemon(by name: String, index: Int)
    func navigateToViewController(index: Int)
}

protocol PokemonListViewProtocol: AnyObject {
    func showAlertWith(title: String, message: String, actions: NSArray?)
    func updateView(with pokemonItem: PokemonListItemViewModel, indexPath: Int)
    func reloadData()
}

class PokemonListPresenter: PokemonListPresenterProtocol {
    
    private let loggerSystem: LoggerSystem
    
    private let pokemonUseCase: PokemonUseCase
    var viewModel: PokemonListViewModel?
    weak var view: PokemonListViewProtocol?
    var router: PokemonListRouter?
    
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
                
                self.loggerSystem.logger(type: .success, message: "Fetched Pokemon List: \n \(pokemonListItemViewModel)", info: nil)

                DispatchQueue.main.async {
                    self.viewModel = PokemonListViewModel(pokemonListItemViewModel: pokemonListItemViewModel)
                    self.view?.reloadData()
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
            case .failure(let error):
                self.loggerSystem.logger(type: .error, message: error.localizedDescription, info: "File: \(#fileID):\(#line) --> func: \(#function)")
            }
        }
    }
    
    func navigateToViewController(index: Int) {
        if let poke = viewModel?.pokemonListItemViewModel[index] {
            guard let imageData = poke.imageData else {
                router?.natigateToPokemonDetails(pokeDTO: PokeDTO(name: poke.name, imageData: nil), usecase: pokemonUseCase)
                return
            }
            router?.natigateToPokemonDetails(pokeDTO: PokeDTO(name: poke.name, imageData: imageData), usecase: self.pokemonUseCase)
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
