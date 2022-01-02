//
//  LoginViewTests.swift
//  LoginTaskTests
//
//  Created by Sajeev Raj on 02/01/2022.
//

import XCTest
import ViewInspector
import GoogleSignIn

@testable import LoginTask

class MockLoginService: LoginServiceProtocol {
    func signInWithGoogle(viewController: UIViewController, completion: @escaping (Result<GIDProfileData, Error>) -> Void) {
        
    }
    
}

class LoginViewTests: XCTestCase {
    
    func testIfWelcomeTextShown() throws {
        let loginViewSubject = LoginView(viewModel: AuthenticationViewModel(service: MockLoginService()))
        let text = try loginViewSubject.inspect().navigationView().zStack(0).vStack(2).text(0).string()
        XCTAssertEqual(text, "Welcome")
    }
    
    func testIfGoogleButtonIsShwon() throws {
        let loginViewSubject = LoginView(viewModel: AuthenticationViewModel(service: MockLoginService()))
        loginViewSubject.signedInState = .signedOut
        let button = try loginViewSubject.inspect().find(button: "Sign In with Google")
        XCTAssertNotNil(button)
    }
}

extension LoginView: Inspectable {}
