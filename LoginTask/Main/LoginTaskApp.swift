//
//  LoginTaskApp.swift
//  LoginTask
//
//  Created by Sajeev Raj on 20/12/2021.
//

import SwiftUI

@main
struct LoginTaskApp: App {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some Scene {
      WindowGroup {
        ContentView()
          .environmentObject(viewModel)
      }
    }
}
