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
    @Published private(set) var error: Error?

    func signIn(type: SignInMode,
                from viewController: UIViewController) {
        
        switch type {
        case .google:
            // handle google sign in case
        let configuration = GIDConfiguration(clientID: "686900365153-42p9bnd5joqk5rt41fqjthe1u89mqlp1.apps.googleusercontent.com")
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: viewController) { [weak self] (user, error) in
                if let googleSignInError = error {
                    self?.error = googleSignInError
                    return
                }
                guard let googleUser = user else {
                    return
                }
                // map to View model
                let viewModel = UserViewModel(name: googleUser.profile?.name ?? "", email: googleUser.profile?.email ?? "")
                self?.state = .signedIn
            }
        default:
            break
            
        }
    }
    
    func validate() {
        
    }
}
