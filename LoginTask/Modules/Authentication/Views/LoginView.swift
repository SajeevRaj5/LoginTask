//
//  LoginView.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authentication: Authentication

    @State var viewModel: AuthenticationViewModel
    @State var isActive = false
    
    //MARK: - PROPERTIES
    @State var username: String = ""
    @State var password: String = ""
    @State private var isCredentialsValid: Bool = true
    @State private var showHomeScreen: Bool = false

    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea(.all)
                Spacer()
                
                VStack {
                    Text("Welcome")
                    LoginTextField(text: username, placeHolderText: "Username", iconName: "person")
                    
                    LoginTextField(text: password, placeHolderText: "Password", iconName: "lock")
                    
                    Text("Incorrect credentials")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                        .hidden(isCredentialsValid)
                    
                    //  Button SignIn
                    Button(action: {
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
                            self.authentication.state = .signedIn(userViewModel: viewModel)
                        })
                    }){
                        Text("Google Sign In")
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
        LoginView(viewModel: AuthenticationViewModel())
    }
}

struct LoginTextField: View {
    @State var text: String = ""
    @State var placeHolderText: String = ""
    @State var iconName: String = ""

    var body: some View {
        Label {
            CustomTextField(placeholder: Text(placeHolderText), fontName: "NunitoSans-Regular", fontSize: 16, fontColor: Color.white, foregroundColor: Color.white, textValue: $text)
        } icon: {
            Image(systemName: iconName)
                .frame(width: 14, height: 14)
                .padding(.leading)
        }.frame(height: 45)
        .overlay(Rectangle().stroke(Color.white, lineWidth: 0.5).frame(height: 45))
    }
}
