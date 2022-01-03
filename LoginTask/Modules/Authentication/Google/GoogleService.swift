//
//  GoogleService.swift
//  LoginTask
//
//  Created by Sajeev Raj on 31/12/2021.
//

import Foundation
import GoogleSignIn

class GoogleService {
    static func autoLogin(completion: @escaping (Result<GIDProfileData, Error>) -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { (user, error) in
            if let googleSignInError = error {
                completion(.failure(googleSignInError))
            }
            guard let googleUser = user?.profile else {
                return
            }
            completion(.success(googleUser))
        }
    }
    
    static func signIn(viewController: UIViewController, completion: @escaping (Result<GIDProfileData, Error>) -> Void) {
        guard let clientID = Configuration.current.googleClientID else { return }
        let configuration = GIDConfiguration(clientID: clientID)
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
