//
//  ErrorAlert.swift
//  LoginTask
//
//  Created by Sajeev Raj on 14/12/2021.
//

import SwiftUI

protocol ErrorHandler {
    func handle<T: View>(
        _ error: Error?,
        in view: T,
        actionHandler: @escaping () -> Void
    ) -> AnyView
}

struct AlertErrorHandler: ErrorHandler {
    private let id = UUID()
    
    func handle<T: View>(
        _ error: Error?,
        in view: T,
        actionHandler: @escaping () -> Void
    ) -> AnyView {
        
        var presentation = error.map { Presentation(
            id: id,
            error: $0,
            actionHandler: actionHandler
        )}
        
        let binding = Binding(
            get: { presentation },
            set: { presentation = $0 }
        )
        
        return AnyView(view.alert(item: binding, content: makeAlert))
    }
}

private extension AlertErrorHandler {
    struct Presentation: Identifiable {
        let id: UUID
        let error: Error
        let actionHandler: () -> Void
    }
    
    func makeAlert(for presentation: Presentation) -> Alert {
        let error = presentation.error
        return Alert(
            title: Text("An error occured"),
            message: Text(error.localizedDescription),
            dismissButton: .default(Text("Ok"))
        )
    }
}

struct ErrorHandlerEnvironmentKey: EnvironmentKey {
    static var defaultValue: ErrorHandler = AlertErrorHandler()
}

extension EnvironmentValues {
    var errorHandler: ErrorHandler {
        get { self[ErrorHandlerEnvironmentKey.self] }
        set { self[ErrorHandlerEnvironmentKey.self] = newValue }
    }
}

extension View {
    func handlingErrors(
        using handler: ErrorHandler
    ) -> some View {
        environment(\.errorHandler, handler)
    }
    
    func emittingError(
        _ error: Error?,
        actionHandler: @escaping () -> Void
    ) -> some View {
        modifier(ErrorEmittingViewModifier(
            error: error,
            actionHandler: actionHandler
        ))
    }
}

struct ErrorEmittingViewModifier: ViewModifier {
    @Environment(\.errorHandler) var handler

    var error: Error?
    var actionHandler: () -> Void

    func body(content: Content) -> some View {
        handler.handle(error,
                       in: content,
                       actionHandler: actionHandler)
    }
}
