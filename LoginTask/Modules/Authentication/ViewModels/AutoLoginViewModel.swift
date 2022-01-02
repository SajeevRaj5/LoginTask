//
//  AutoLoginViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 02/01/2022.
//

import SwiftUI
import LocalAuthentication

class AutoLoginViewModel {
    let context = LAContext()
    @Published private(set) var isAuthorized: Bool = false

    private var authentication: Authentication
    var error: NSError?

    init(authentication: Authentication) {
        self.authentication = authentication
    }
   
    func checkAuthentication(completion: @escaping (UserViewModel?) -> ()) {
        
        guard let loggedInMode = authentication.loggedInMode else {
            authentication.state = .signedOut
            completion(nil)
            return
        }
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need authentication to auto login you to the app."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                // auto login user with mode. We don't want to show user error in this case. If auto login fails, direct user to Login screen
                if success {
                    self.autoLogin(mode: loggedInMode) { (result) in
                        switch result {
                        case .success(let viewModel):
                            completion(viewModel)
                        case .failure:
                            completion(nil)
                        }
                    }
                }
                else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }

    }
    
    func autoLogin(mode: Authentication.Mode, completion: @escaping (Result<UserViewModel, Error>) -> ()) {
        switch mode {
        case .google:
            GoogleService.autoLogin { (result) in
                switch result {
                case .success(let user):
                    let viewModel = UserViewModel(user: User(name: user.name,email: user.email ))
                    completion(.success(viewModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        default:
            break
        }
    }
}
