//
//  PokemonDetailsViewController.swift
//  Pokechallenge
//
//  Created by André Silva on 14/02/2024.
//

import Foundation

class PokemonDetailsViewController: BaseViewController {
    
    private var presenter: PokemonDetailsPresenter
    
    init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
