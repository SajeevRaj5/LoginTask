//
//  Authentication.swift
//  LoginTask
//
//  Created by Sajeev Raj on 30/12/2021.
//

import Foundation
import SwiftUI
import LocalAuthentication

enum SignInState {
    case signedIn(userViewModel: UserViewModel)
    case signedOut
}

class Authentication: ObservableObject {
    @Published var state: SignInState = .signedOut
    
    var error: NSError?
    
    var loggedInMode: Mode? {
        get {
            if let modeStringValue = UserDefaults.standard.value(forKey: "LoggedInMode") as? String {
               let mode = Mode(rawValue: modeStringValue)
                return mode
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "LoggedInMode")
        }
    }
    
    let context = LAContext()
    
    func checkAuthentication(completion: @escaping (UserViewModel?) -> ()) {
        
        // since we are not handling error in this case, passing nil. We can pass error in case we need to show the user any error
        guard let loggedInMode = self.loggedInMode else {
            completion(nil)
            return
        }
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need authentication to auto login you to the app."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                // auto login user with mode. We don't want to show user error in this case. If auto login fails, direct user to Login screen
                loggedInMode.autoLogin { (result) in
                    switch result {
                    case .success(let viewmodel):
                        completion(viewmodel)
                    case .failure:
                        completion(nil)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }

}

extension Authentication {
    enum Mode: String {
        case google
        case email
        case apple
        
        func autoLogin(completion: @escaping (Result<UserViewModel, Error>) -> ()) {
            switch self {
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
}
