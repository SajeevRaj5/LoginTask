//
//  AuthenticationViewModelTests.swift
//  LoginTaskTests
//
//  Created by Sajeev Raj on 02/01/2022.
//

import XCTest

@testable import LoginTask

class AuthenticationViewModelTests: XCTestCase {
    
    var viewModel: AuthenticationViewModel!
    var mockService: MockLoginService!
    
    override func setUp() {
        mockService = MockLoginService()
        viewModel = .init(service: mockService)
        
    }
}
