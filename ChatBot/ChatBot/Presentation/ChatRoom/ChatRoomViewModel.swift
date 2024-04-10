import Foundation
import Combine

enum ChatRoomModelError: Error, Equatable {
    case chattingFetch
}

enum ChatRoomModelState: Equatable {
    case loading
    case finishedLoading
    case error(ChatRoomModelError)
}

final class ChatRoomViewModel {
    @Published private(set) var comments: [ChatRoomModel] = []
    @Published private(set) var state: ChatRoomModelState = .finishedLoading
    private var requestMessage: [Message] = [Message(role: .system, content: 
    "UserQuestion과 GPTAnswer가 주고 받는 대화를 참고해서 답변을 해주세요!", toolCalls: nil)]
    
    private let mapper: Mappable
    private var bindings = Set<AnyCancellable>()
    
    init(mapper: Mappable = Mapper(dataDecoder: DataDecoder(networkManager: NetworkManager()))) {
        self.mapper = mapper
    }
    
    func askQuestion(query: String) {
        fetchData(with: query)
    }
}

//네트워크 데이터 가져오는 부분
extension ChatRoomViewModel {
    private func fetchData(with question: String?) {
        state = .loading
        
        let questionCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self]
            completion in
            
            switch completion {
            case .failure:
                self?.state = .error(.chattingFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }
        
        let questionValueHander: ([ChatRoomModel]) -> Void = { [weak self] messages in
            self?.comments = messages
        }
        
        guard let question = question else { return }
    
        requestMessage.append(Message(role: .user, content: question, toolCalls: nil))
        
        mapper.mapChatGPTContent(with: requestMessage)
            .sink(receiveCompletion: questionCompletionHandler, receiveValue: questionValueHander)
            .store(in: &bindings)
    }
}
