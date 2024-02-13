//
//  PokemonListCell.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import UIKit

class PokemonListCell: UICollectionViewCell {
    
    // MARK: - UIViews
    let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        return image
    }()
    
    let PokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center

        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(pokemonItem: PokemonListItemViewModel) {
        self.PokemonNameLabel.text = pokemonItem.name
//        self.pokemonImage.image = UIImage(data: pokemonItem.image)
    }
    
    private func setupSubviews() {
        contentView.addSubview(PokemonNameLabel)
        contentView.addSubview(pokemonImage)

        let constraintspokemonImage = [
            pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImage.bottomAnchor.constraint(equalTo: PokemonNameLabel.topAnchor)
        ]

        let constraintsPokemonNameLabel = [
            PokemonNameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor),
            PokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            PokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            PokemonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            PokemonNameLabel.heightAnchor.constraint(equalToConstant: 15)
        ]

        NSLayoutConstraint.activate(constraintsPokemonNameLabel + constraintspokemonImage)
    }
}
