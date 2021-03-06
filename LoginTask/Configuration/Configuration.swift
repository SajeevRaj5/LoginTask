//
//  Configuration.swift
//  LoginTask
//
//  Created by Sajeev Raj on 03/01/2022.
//

import Foundation

class Configuration {
    
    // the current singleton configuration
    static let current = Configuration()
    
    // all configurations
    private var all = [String: Any]()
    
    private init() {
        
        // load all configurations
        all = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? [String: Any] ?? [:]
        
        if let clientId = all["googleClientID"] as? String {
            googleClientID = clientId
        } else {
            googleClientID = nil
        }
        
        loginUsername = all["loginUsername"] as? String
        loginPassword = all["loginPassword"] as? String
        loginEmail = all["loginEmail"] as? String
    }
    
    let googleClientID: String?
    let loginUsername: String?
    let loginPassword: String?
    let loginEmail: String?
}
