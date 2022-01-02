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
        if (authentication.loggedInMode != nil) {
            AutoLoginView(viewModel: AutoLoginViewModel(authentication: authentication))
                .environmentObject(authentication)
        }
        else {
            LoginView(viewModel: AuthenticationViewModel())
                .environmentObject(authentication)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
