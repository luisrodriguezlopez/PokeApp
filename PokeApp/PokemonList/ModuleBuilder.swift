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


    static func createSwiftUIModule() -> some View {
        let view = PokemonListView()
        return view
    }

}
