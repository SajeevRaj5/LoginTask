//
//  HomeViewTests.swift
//  LoginTaskTests
//
//  Created by Sajeev Raj on 03/01/2022.
//

import XCTest
import ViewInspector
@testable import LoginTask

class HomeViewTests: XCTestCase {
    var viewModel: UserViewModel!
    
    override func setUp() {
        viewModel = UserViewModel(user: User(name: "abc", email: "abc@gmail.com"))
    }
    
    func testIfNameIsPopulated() throws {
        let homeView = HomeView(viewModel: viewModel)
        let text = try homeView.inspect().zStack().vStack(0).text(1).string()
        XCTAssertEqual(text, "Welcome abc")
    }
    
    func testIfEmailIsPopulated() throws {
        let homeView = HomeView(viewModel: viewModel)
        let text = try homeView.inspect().zStack().vStack(0).text(2).string()
        XCTAssertEqual(text, "Email : abc@gmail.com")
    }
    
    func testSignOut() throws {
        var homeView = HomeView(viewModel: viewModel)
        let expectation = homeView.on(\.didAppear) { view in
            let button = try homeView.inspect().find(button: "Log out")
            try button.tap()
            XCTAssertEqual(homeView.authentication.state, SignInState.signedOut)
        }
        ViewHosting.host(view: homeView.environmentObject(Authentication()))
        wait(for: [expectation], timeout: 0.1)
    }
}

extension HomeView: Inspectable {}
