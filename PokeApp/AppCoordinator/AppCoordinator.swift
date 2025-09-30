//
//  AppCoordinator.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 26/09/25.
//
import SwiftUI
import UIKit
import AuthenticationServices
protocol AppCoordinatorProtocol {
    func start()
    func showPokemonList()
}
class AppCoordinator: AppCoordinatorProtocol {
    var navigationController : UINavigationController

    private let credentialChecker: CredentialStateChecking

      init(navigationController: UINavigationController,
           credentialChecker: CredentialStateChecking = AppleCredentialStateChecker()) {
          self.navigationController = navigationController
          self.credentialChecker = credentialChecker
      }


    

    func start() {
      //  let hostingVC =  UIHostingController(rootView:  PokemonListModule.createSwiftUIModule())
        credentialChecker.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { credentialState in

            switch credentialState {
            case .authorized:
                self.showPokemonList()
                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                    self.showLogin()
                }
            default:
                break
            }
        }
    }

    func showPokemonList() {
        DispatchQueue.main.async {
            let hostingVC =  UIHostingController(rootView:  PokemonListModule.createSwiftUIModule())
            self.navigationController.pushViewController(hostingVC, animated: true)
        }

    }

    func showLogin() {
        let LoginVC = LoginViewController()
        self.navigationController.pushViewController(LoginVC, animated: true)
    }
}


protocol CredentialStateChecking {
    func getCredentialState(forUserID: String,
                            completion: @escaping (ASAuthorizationAppleIDProvider.CredentialState) -> Void)
}

class AppleCredentialStateChecker: CredentialStateChecking {
    func getCredentialState(forUserID: String,
                            completion: @escaping (ASAuthorizationAppleIDProvider.CredentialState) -> Void) {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: forUserID) { state, _ in
            completion(state)
        }
    }
}


