//
//  AppDelegate.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 25/09/25.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        appCoordinator = AppCoordinator(window: window ?? UIWindow(frame: UIScreen.main.bounds))
               appCoordinator?.start()


        return true
    }



}

