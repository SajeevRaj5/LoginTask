//
//  LoginView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authentication: Authentication

    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        
        switch viewModel.signedInState{
        case .signedOut:
            LoginInScreenView()
        case .signedIn(let userViewModel):
            HomeView(viewModel: userViewModel)
        default:
            LoginInScreenView()
        }
    }
    
    private func LoginInScreenView() -> some View {
        return NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea(.all)
                Spacer()
                
                VStack {
                    Text("Welcome")

                    // Username field
                    Label {
                        CustomTextField(placeholder: Text("Username"), fontName: "NunitoSans-Regular", fontSize: 16, fontColor: Color.white, foregroundColor: Color.white, textValue: $viewModel.username)
                    } icon: {
                        Image(systemName: "person")
                            .frame(width: 14, height: 14)
                            .padding(.leading)
                    }.frame(height: 45)
                    .overlay(Rectangle().stroke(Color.white, lineWidth: 0.5).frame(height: 45))
                    
                    // Password field
                    Label {
                        CustomTextField(placeholder: Text("Password"), fontName: "NunitoSans-Regular", fontSize: 16, fontColor: Color.white, foregroundColor: Color.white, isSecureText: true, textValue: $viewModel.password)
                    } icon: {
                        Image(systemName: "lock")
                            .frame(width: 14, height: 14)
                            .padding(.leading)
                    }.frame(height: 45)
                    .overlay(Rectangle().stroke(Color.white, lineWidth: 0.5).frame(height: 45))
                    
                    
                    //  Button SignIn
                    Button(action: {
                        viewModel.signIn(username: viewModel.username, password: viewModel.password) { (userViewModel) in
                            self.authentication.loggedInMode = .email
                            self.viewModel.signedInState = .signedIn(userViewModel: userViewModel)
                        }
                    }){
                        Text("Sign In")
                            .modifier(CustomText(fontName: "NunitoSans-Bold", fontSize: 16, fontColor: .black))
                    }
                    .modifier(CustomButton())
                    .background(Color.white)
                    .padding(.vertical,10)
                    
                    //  Button Google SignIn
                    Button(action: {
                        let rootView = getRootViewController()
                        viewModel.signIn(type: .google, from: rootView, completion: { viewModel in
                            self.authentication.loggedInMode = .google
                            self.viewModel.signedInState = .signedIn(userViewModel: viewModel)
                        })
                    }){
                        Text("Sign In with Google")
                            .modifier(CustomText(fontName: "NunitoSans-Bold", fontSize: 16, fontColor: .white))
                    }
                    .modifier(CustomButton())
                    .background(Color.red)
                    .padding(.vertical,30)
                }
                .emittingError(viewModel.error, actionHandler: {
                    print("Alert dismissed")
                })
                .foregroundColor(.white)
                .padding(.horizontal,20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
