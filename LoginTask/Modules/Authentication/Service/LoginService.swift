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
        GoogleService.signIn(viewController: viewController, completion: completion)
    }
}
