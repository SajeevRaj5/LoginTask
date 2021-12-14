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
}
