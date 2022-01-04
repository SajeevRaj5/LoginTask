//
//  CustomTextField.swift
//  LoginTask
//
//  Created by Sajeev Raj on 09/12/2021.
//

import SwiftUI

struct CustomTextField: View {
    //MARK:- PROPERTIES
    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var foregroundColor: Color?
    var isSecureText: Bool = false
    
    @Binding var textValue: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if textValue.isEmpty { placeholder
                                        .modifier(CustomText(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
            if isSecureText {
                SecureField("", text: $textValue, onCommit: commit)
                    .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
            }
            else {
                TextField("", text: $textValue, onEditingChanged: editingChanged, onCommit: commit)
                    .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
            }
        }
    }
}
