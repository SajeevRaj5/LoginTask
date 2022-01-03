//
//  AuthenticationViewModelTests.swift
//  LoginTaskTests
//
//  Created by Sajeev Raj on 02/01/2022.
//

import XCTest
import GoogleSignIn

@testable import LoginTask

class AuthenticationViewModelTests: XCTestCase {
    
    var viewModel: AuthenticationViewModel!
    var mockService: MockLoginService!
    
    override func setUp() {
        mockService = MockLoginService()
        viewModel = .init(service: mockService)
    }
    
    func testGoogleLoginSuccess() {
        mockService.loginResult = .success(GIDProfileData())
        viewModel.signIn(type: .google, from: UIViewController()) { (userViewModel) in
            XCTAssertEqual(self.viewModel.signedInState, SignInState.signedIn(userViewModel: userViewModel))
        }
    }
    
    func testGoogleLoginFailure() {
        let error = NSError(domain: "", code: 100, userInfo: nil)
        mockService.loginResult = .failure(error)
        viewModel.signIn(type: .google, from: UIViewController()) { (userViewModel) in
            XCTAssertEqual(self.viewModel.signedInState, SignInState.signedOut)
        }
    }
}
