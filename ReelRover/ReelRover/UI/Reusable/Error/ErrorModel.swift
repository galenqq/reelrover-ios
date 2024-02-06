import Foundation

/// Model which helps parse our errors. 
struct ErrorModel {
    
    // MARK: - Init
    
    let title: String
    let message: String
    
    init(_ error: Error?) {
        guard let error = error as? LocalizedError else {
            if let localizedDescription = error?.localizedDescription {
                self.init(customMessage: localizedDescription)
            } else {
                self.init(localizedError: UnknownError())
            }
            return
        }
    
        self.init(localizedError: error)
    }
    
    private init(localizedError: LocalizedError) {
        self.title = localizedError.failureReason ?? "Error"
        self.message = localizedError.errorDescription ?? "Please try again."
    }
    
    private init(customMessage: String) {
        self.title = "Error"
        self.message = customMessage
    }
    
    // MARK: - Helper
    
    var description: String {
        return title.isEmpty
            ? message
            : "\(title)\n\(message)"
    }
}

/// Default unknown error for rare situations where an error cannot be parsed. 
struct UnknownError: Error, LocalizedError, Equatable {
    var failureReason: String? {
        return "Error"
    }
    
    var errorDescription: String? {
        return "Please try again."
    }
}
