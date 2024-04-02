import Foundation

import Foundation

enum URLInformation {
    case completion
    
    var path: String {
        switch self {
        case .completion:
            return "/v1/chat/completions"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let urlQueryItems: [URLQueryItem]? = nil
        
        switch self {
        case .completion:
            return urlQueryItems
        }
    }
}
