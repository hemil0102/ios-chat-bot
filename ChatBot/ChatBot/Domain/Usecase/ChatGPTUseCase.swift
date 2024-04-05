import Foundation
import Combine

final class ChatGPTUseCase: ChatGPTUseCaseProtocol {
    private let mapper: Mappable
    
    init(mapper: Mappable) {
        self.mapper = mapper
    }
    
    func fetchChatGPTContent(with messages: [Message]) -> AnyPublisher<GPTResponse, Error> {
        return mapper.mapChatGPTContent(with: messages)
    }
}
