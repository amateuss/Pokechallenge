//
//  PokemonListViewController.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import UIKit

class PokemonListViewController: BaseViewController {
    // MARK: - Properties
    private var presenter: PresenterProtocol
    
    // MARK: - UIViews
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    private func initializeUI() {
        addSubViews()
        setupDelegates()
        setupConfigCollectionView()
        setupConstraints()
        presenter.getPokemons()
        
        view.backgroundColor = .white
    }
    
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource =  self

        presenter.view = self
    }
    
    private func setupConfigCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: 100, height: 100)
                layout.scrollDirection = .horizontal


        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)

        if let cvl = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            cvl.itemSize = isList ? getCellSize() : getCellSizeList()
            cvl.itemSize = getCellSize()
        }
    }
    
    private func getCellSize(indexPath : IndexPath? = nil) -> CGSize {
        var width =  UIScreen.main.bounds.width / 2

        if UIScreen.main.bounds.width > 600 {
            width =  UIScreen.main.bounds.width / 3
        }
        width = width - 34

        return CGSize(width: width, height: width * 1.14 )
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintsCollectionView = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsCollectionView)
    }
}

// MARK: UICollectionView and UICollectionViewDataSource delegates
extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let pokemonList = presenter.viewModel?.pokemonListItemViewModel.count {
            return pokemonList
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! PokemonListCell

        if let pokemonItem = presenter.viewModel?.pokemonListItemViewModel[indexPath.row] {
            cell.setup(pokemonItem: pokemonItem)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellSize = getCellSize()

        let numberOfCells = floor(view.frame.size.width / cellSize.width)
        let edgeInsets = (view.frame.size.width - (numberOfCells * cellSize.width)) / (numberOfCells + 1)

        return UIEdgeInsets(top: edgeInsets , left: edgeInsets, bottom: edgeInsets*2, right: edgeInsets)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return isList ? getCellSize() : getCellSizeList()
//    }
}

// MARK: ViewProtocol
extension PokemonListViewController: ViewProtocol {
    
    func showAlertWith(title: String, message: String, actions: NSArray?) {
        showAlert(with: title, message: message, actions: actions)
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Constants
private extension PokemonListViewController {
    enum Constants {
        static let cellIdentifier = "pokemonListCell"
    }
}
