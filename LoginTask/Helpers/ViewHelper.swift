//
//  ViewHelper.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    
    func withErrorHandling() -> some View {
        modifier(HandleErrorsByShowingAlertViewModifier())
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
