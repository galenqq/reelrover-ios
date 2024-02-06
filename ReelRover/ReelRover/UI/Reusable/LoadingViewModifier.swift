import SwiftUI

/// Helper struct which allows for a full screen modal loader to be attached to a view easily.
struct LoadingViewModifier: ViewModifier {
    
    // MARK: - Init
    
    @Binding var isLoading: Bool
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0.8 : 1)
            .disabled(isLoading)
            .overlay {
                isLoading
                    ? ProgressView().controlSize(.extraLarge)
                    : nil
            }
    }
}

extension View {
    func loader(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
