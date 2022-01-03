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
    
    var body: some View {
        
        switch authentication.state {
        case .undetermined:
            Text("Trying to auto login....")
                .onAppear(perform: checkAuthentication)
        case .signedIn(let userViewModel):
            HomeView(viewModel: userViewModel)
        case .signedOut:
            LoginView(viewModel: LoginViewModel())
        }

    }
    
    private func checkAuthentication() {
        viewModel.handleAuthentication()
    }
}
