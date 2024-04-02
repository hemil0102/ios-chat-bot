import Foundation
import Combine

class NetworkManager: Fetchable {
    
    func fetchData() -> AnyPublisher<Data, Error> {
        
        guard let request = RequestProvider(requestInformation: .completion(model: .basic, messages: [Message(role: .system, content: "You are an assistant that occasionally misspells words", toolCalls: nil), Message(role: .user, content: "Tell me a story.", toolCalls: nil)], logprobs: nil)).request else {
            return Fail(error: NetworkError.networkError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.networkError
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
