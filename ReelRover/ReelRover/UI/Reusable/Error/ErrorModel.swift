import Foundation

/// Model which helps parse our errors. 
struct ErrorModel {
    let title: String
    let message: String
    
    var description: String {
        return title.isEmpty
            ? message
            : "\(title)\n\(message)"
    }
    
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
}

struct UnknownError: Error, LocalizedError, Equatable {
    var failureReason: String? {
        return "Error"
    }
    
    var errorDescription: String? {
        return "Please try again."
    }
}
