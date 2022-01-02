//
//  LoginService.swift
//  LoginTask
//
//  Created by Sajeev Raj on 20/12/2021.
//

import SwiftUI
import GoogleSignIn

protocol LoginServiceProtocol {
    func signInWithGoogle(viewController: UIViewController, completion: @escaping (Result<GIDProfileData, Error>) -> Void)
}

class LoginService: LoginServiceProtocol {
    
    func signInWithGoogle(viewController: UIViewController, completion: @escaping (Result<GIDProfileData, Error>) -> Void) {
        let configuration = GIDConfiguration(clientID: "686900365153-42p9bnd5joqk5rt41fqjthe1u89mqlp1.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: viewController) { (user, error) in
            if let googleSignInError = error {
                completion(.failure(googleSignInError))
            }
            guard let googleUser = user?.profile else {
                return
            }
            completion(.success(googleUser))
        }
    }
}
