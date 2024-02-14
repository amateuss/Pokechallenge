//
//  PokemonDetailsViewController.swift
//  Pokechallenge
//
//  Created by André Silva on 14/02/2024.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {
    
    private var presenter: PokemonDetailsPresenter
     
    let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchPokemon()
        addSubViews()
        setupConstraints()
        
        presenter.view = self
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func addSubViews() {
        view.addSubview(pokemonImage)
        view.addSubview(nameLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
    }
    
    private func setupConstraints() {
        
        let imageConstraint = [
            pokemonImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            pokemonImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ]
        
        let nameLabelConstraint = [
            nameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
        ]

        let heightLabelConstraint = [
            heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            heightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ]
        
        let weightLabelConstraint = [
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            weightLabel.heightAnchor.constraint(equalToConstant: 16)
        ]

        NSLayoutConstraint.activate(imageConstraint + nameLabelConstraint + heightLabelConstraint + weightLabelConstraint)
    }
    
    func updateUI() {
        if let viewModel = presenter.viewModel {
            if let data = viewModel.imageData {
                pokemonImage.image = UIImage(data: data)
            }
            
            nameLabel.text = viewModel.name
            heightLabel.text = String(viewModel.height)
            weightLabel.text = String(viewModel.weight)
        }
    }
}

// MARK: ViewProtocol
extension PokemonDetailsViewController: PokemonDetailsViewProtocol {
    
    func showAlertWith(title: String, message: String, actions: NSArray?) {
        showAlert(with: title, message: message, actions: actions)
    }

    func reloadData() {
        self.viewWillAppear(false)
    }
}

