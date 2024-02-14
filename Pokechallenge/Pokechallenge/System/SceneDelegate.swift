//
//  SceneDelegate.swift
//  Pokechallenge
//
//  Created by André Silva on 10/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let pokemonListViewController = PokemonListAssembly.pokemonListViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: pokemonListViewController)
        window?.makeKeyAndVisible()
    }
}

