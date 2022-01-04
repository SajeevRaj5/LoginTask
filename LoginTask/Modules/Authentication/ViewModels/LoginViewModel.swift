//
//  LoginViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 14/12/2021.
//

import GoogleSignIn
import SwiftUI

final class LoginViewModel: NSObject, ObservableObject {
    
    enum SignInMode {
        case google
        case apple
        case facebook
    }

    @Published private(set) var error: Error?
    @Published var signedInState: SignInState = .undetermined
    
    //MARK: - PROPERTIES
    @Published var username: String = ""
    @Published var password: String = ""

    private let service: LoginServiceProtocol
    
    init(service: LoginServiceProtocol = LoginService()) {
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
    
    func signIn(username: String,
                  password: String,
                  completion: @escaping (UserViewModel) -> ()) {
        if username.isEmpty || password.isEmpty {
            let emptyError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Fields cannot be empty"])
            self.error = emptyError
            return
        }
        if (username != Configuration.current.loginUsername) || (password != Configuration.current.loginPassword) {
            let emptyError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Incorrect credentials"])
            self.error = emptyError
            return
        }
        let viewModel = UserViewModel(user: User(name: username,email: Configuration.current.loginEmail ?? "" ))
        clearValues()
        completion(viewModel)
    }
    
    private func clearValues() {
        username = ""
        password = ""
    }
}
