//
//  Authentication.swift
//  LoginTask
//
//  Created by Sajeev Raj on 30/12/2021.
//

import Foundation
import SwiftUI

enum SignInState: Equatable {
    case signedIn(userViewModel: UserViewModel)
    case signedOut
    case undetermined
}

class Authentication: ObservableObject {
    @Published var state: SignInState = .undetermined {
        didSet {
            switch state {
            case .signedOut:
                UserDefaults.standard.set(nil, forKey: "LoggedInMode")
            default:
                break
            }
        }
    }
    
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

}

extension Authentication {
    enum Mode: String {
        case google
        case email
        case apple
    }
}
