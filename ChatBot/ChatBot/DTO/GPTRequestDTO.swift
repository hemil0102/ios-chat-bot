import Foundation

// MARK: - GPTRequestDTO
struct GPTRequestDTO: Encodable {
    let model: String
    let messages: [Message]
    let logprobs: Bool?
    
    enum CodingKeys: String, CodingKey {
        case model, messages, logprobs
    }
}
