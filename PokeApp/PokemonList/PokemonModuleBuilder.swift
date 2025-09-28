//
//  ModuleBuilder.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 26/09/25.
//
import SwiftUI
import UIKit
enum PokemonListModule {

    static func createUIKitModule() -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }


    @MainActor static func createSwiftUIModule() -> some View {

            let repository = RemotePokemonRepository() // o Fake for dev
            let presenter = PokemonListPresenter()
            let interactor = PokemonListInteractor(repository: repository, presenter: presenter)
        return    PokemonListView(presenter: presenter, interactor: interactor)

    }

}
