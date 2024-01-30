import SwiftUI

/// Helper struct which allows for an error to be processed as an alert easily.
struct ErrorAlertModifier: ViewModifier {
    
    @Binding var error: Error?
    
    private var isPresented: Binding<Bool> {
        Binding(
            get: {
                error != nil
            },
            set: {
                if $0 == false { error = nil }
            }
        )
    }
    
    private var errorModel: ErrorModel { ErrorModel(error) }
    
    func body(content: Content) -> some View {
        content
            .alert(
                errorModel.title,
                isPresented: isPresented,
                actions: {
                    Button("Ok") {
                        //nop
                    }
                },
                message: {
                    Text(errorModel.message)
                }
            )
    }
}


extension View {
    func alert(_ error: Binding<Error?>) -> some View {
        modifier(ErrorAlertModifier(error: error))
    }
}
