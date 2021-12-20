//
//  AuthenticationViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 14/12/2021.
//

import GoogleSignIn

class AuthenticationViewModel: NSObject, ObservableObject {
    
    enum SignInMode {
        case google
        case apple
        case facebook
    }
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signIn(type: SignInMode, from viewController: UIViewController) {
        
        switch type {
        case .google:
            // handle google sign in case
        let configuration = GIDConfiguration(clientID: "686900365153-42p9bnd5joqk5rt41fqjthe1u89mqlp1.apps.googleusercontent.com")
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: viewController) { [weak self] (user, error) in
                guard let googleUser = user else {
                    
                    return
                }
                self?.state = .signedIn
            }
        default:
            break
            
        }
    }
    
    func validate() {
        
    }
}
