import Foundation
import Combine

final class Mapper: Mappable {
    private let dataDecoder: DataDecodable
    
    init(dataDecoder: DataDecodable) {
        self.dataDecoder = dataDecoder
    }
    
    func mapChatGPTContent(with messages: [Message]) -> AnyPublisher<GPTResponse, Error> {
        return dataDecoder.decodedChatGPTCompletionData(with: messages, type: GPTResponseDTO.self)
            .receive(on: RunLoop.main)
            .map { result in
                return GPTResponse(content: result.choices[0].message.content)
            }
            .eraseToAnyPublisher()
    }
}
