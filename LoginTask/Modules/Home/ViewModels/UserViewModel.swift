//
//  UserViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 20/12/2021.
//

import Foundation

class UserViewModel: NSObject, ObservableObject {
   
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
