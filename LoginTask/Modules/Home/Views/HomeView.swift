//
//  HomeView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 20/12/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authentication: Authentication
    @State var viewModel: UserViewModel
    
    // this is added for view inspector testing
    internal var didAppear: ((Self) -> Void)?
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("Welcome \(viewModel.user.name)")
                Text("Email : \(viewModel.user.email)")
                Spacer()
                Button("Log out") {
                    authentication.state = .signedOut
                }
            }
        }
        .onAppear { self.didAppear?(self) }
    }
}
