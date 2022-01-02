//
//  AuthenticationViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 14/12/2021.
//

import GoogleSignIn
import SwiftUI

class AuthenticationViewModel: NSObject, ObservableObject {
    
    enum SignInMode {
        case google
        case apple
        case facebook
    }

    @Published private(set) var error: Error?
    
    private let service: LoginService
    
    init(service: LoginService = LoginService()) {
        self.service = service
    }

    func signIn(type: SignInMode,
                from viewController: UIViewController,
                completion: @escaping (UserViewModel) -> ()) {
        switch type {
        case .google:
            // handle google sign in case
            service.signInWithGoogle(viewController: viewController) { [weak self] (result) in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        // map to view model
                        let viewModel = UserViewModel(user: User(name: user.name,email: user.email ))
                        completion(viewModel)
                    }
                case .failure(let error):
                    self?.error = error
                }
            }
        default:
            break
        }
    }
    
    func validate() {
        
    }
}
