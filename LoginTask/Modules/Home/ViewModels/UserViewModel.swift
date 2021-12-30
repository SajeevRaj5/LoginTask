//
//  UserViewModel.swift
//  LoginTask
//
//  Created by Sajeev Raj on 20/12/2021.
//

import Foundation

class UserViewModel: NSObject, ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
