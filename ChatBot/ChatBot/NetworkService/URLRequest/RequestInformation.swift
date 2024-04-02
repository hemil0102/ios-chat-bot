import Foundation

enum RequestInformation {
    case completion(model: GPTModel, messages: [Message], logprobs: Bool?)
    
    var url: URL? {
        switch self {
        case .completion:
            return EndPoint(urlInformation: .completion, apiHost:.chatGPT, scheme: .https).url
        }
    }
    
    var httpMethod: String {
        switch self {
        case .completion:
            return "POST"
        }
    }
    
    var allHTTPHeaderFields: [String : String] {
        switch self {
        case .completion:
            return [ "Content-Type" : "application/json",
                     "Authorization" : "Bearer \(ENV.APIKey)" ]
        }
    }
    
    var hTTPBody: Data? {
        switch self {
        case .completion(let model, let messages, let logprobs):
            let comment = GPTRequestDTO(model: .basic, messages: messages, logprobs: logprobs)
            guard let uploadData = try? JSONEncoder().encode(comment) else { return nil }
            return uploadData
        }
    }
}
