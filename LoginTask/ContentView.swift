//
//  ContentView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authentication = Authentication()
    
    var body: some View {
//        switch authentication.state {
//        case .signedIn(let viewModel):
//            HomeView(viewModel: viewModel)
//                .environmentObject(authentication)
//        case .signedOut:
//            LoginView(viewModel: AuthenticationViewModel())
//                .environmentObject(authentication)
//        }
        checkAuthentication()
    }
    
    private func checkAuthentication() {
        authentication.checkAuthentication { (viewModel) in
            guard let userViewModel = viewModel else {
               return LoginView(viewModel: AuthenticationViewModel())
                    .environmentObject(authentication)
                return
            }
           return HomeView(viewModel: userViewModel)
                .environmentObject(authentication)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
