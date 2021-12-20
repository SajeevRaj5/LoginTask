//
//  ContentView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView(viewModel: AuthenticationViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
