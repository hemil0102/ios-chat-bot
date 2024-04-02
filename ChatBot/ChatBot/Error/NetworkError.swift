import Foundation

enum NetworkError: LocalizedError {
    case decodingError
    case encodingError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Decoding error", comment: "")
        case .encodingError:
            return NSLocalizedString("Encoding error", comment: "")
        case .networkError:
            return NSLocalizedString("network error", comment: "")
        }
    }
}
