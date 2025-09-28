//
//  AppCordinatorTest.swift
//  PokeAppTests
//
//  Created by Luis Rodríguez López on 27/09/25.
//

import XCTest
@testable import PokeApp
import SwiftUI
import AuthenticationServices
final class AppCordinatorTest: XCTestCase {
    var sut : AppCoordinator?
    let mockNav = MockNavigationController()


    override func setUp() {
        super.setUp()
        sut =  AppCoordinator(navigationController: mockNav)
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_showPokemonList_whenAuthorized() {
        let expectation = self.expectation(description: "Wait for screen transition to complete")

        sut?.showPokemonList()

        // Forzamos directamente la acción
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            XCTAssertTrue(self.mockNav.pushedVC is UIHostingController<PokemonListView>, "No se mostró la lista de pokemones")
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 2.0)

    }

    func test_showLogin_whenCalled() {

        sut?.showLogin()

        XCTAssertTrue(mockNav.pushedVC is LoginViewController)
    }

    func test_start_whenNotAuthorized_showsLogin() {
        let expectation = self.expectation(description: "Wait for screen transition to complete")

        let mockChecker = MockCredentialChecker()
        mockChecker.simulatedState = .notFound

        let sut = AppCoordinator(navigationController: mockNav,
                                 credentialChecker: mockChecker)

        sut.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            XCTAssertTrue(self.mockNav.pushedVC is LoginViewController)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 2.0)

    }

    func test_start_whenAuthorized_showsPokemonList() {
        let expectation = self.expectation(description: "Wait for screen transition to complete")

        let mockChecker = MockCredentialChecker()
        mockChecker.simulatedState = .authorized

        let sut = AppCoordinator(navigationController: mockNav,
                                 credentialChecker: mockChecker)

        sut.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            XCTAssertTrue(self.mockNav.pushedVC is UIHostingController<PokemonListView>)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)


    }

}



class MockNavigationController: UINavigationController {
    var pushedVC: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}


class MockCredentialChecker: CredentialStateChecking {
    var simulatedState: ASAuthorizationAppleIDProvider.CredentialState = .notFound

    func getCredentialState(forUserID: String,
                            completion: @escaping (ASAuthorizationAppleIDProvider.CredentialState) -> Void) {
        completion(simulatedState)
    }
}


