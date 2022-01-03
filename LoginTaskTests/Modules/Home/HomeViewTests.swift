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
}

extension HomeView: Inspectable {}
