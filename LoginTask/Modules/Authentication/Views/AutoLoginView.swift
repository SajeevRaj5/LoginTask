//
//  AutoLoginView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 02/01/2022.
//

import SwiftUI

struct AutoLoginView: View {
    @EnvironmentObject var authentication: Authentication

    @State var viewModel: AutoLoginViewModel
    @State var loginState: SignInState = .undetermined
    
    var body: some View {
        
        switch loginState {
        case .undetermined:
            Text("Trying to auto login....")
                .onAppear(perform: checkAuthentication)
        case .signedIn(let userViewModel):
            HomeView(viewModel: userViewModel)
        case .signedOut:
            LoginView(viewModel: AuthenticationViewModel())
        }

    }
    
    private func checkAuthentication() {
        viewModel.checkAuthentication { (viewModel) in
            if let userViewModel = viewModel {
                loginState = .signedIn(userViewModel: userViewModel)
            }
            else {
                loginState = .signedOut
            }
        }
    }
}
