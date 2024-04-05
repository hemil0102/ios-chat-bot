import Foundation
import Combine

protocol ChatGPTUseCaseProtocol {
    func fetchChatGPTContent(with messages: [Message]) -> AnyPublisher<GPTResponse, Error>
}

