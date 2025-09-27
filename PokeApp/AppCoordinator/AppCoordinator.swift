//
//  AppCoordinator.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 26/09/25.
//
import SwiftUI
import UIKit

class AppCoordinator {
    var navigationController : UINavigationController
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()

        window.rootViewController = self.navigationController
               window.makeKeyAndVisible()
    }

    func start() {
        let hostingVC =  UIHostingController(rootView:  PokemonListModule.createSwiftUIModule())
        self.navigationController.pushViewController(hostingVC, animated: true)
    }
}


