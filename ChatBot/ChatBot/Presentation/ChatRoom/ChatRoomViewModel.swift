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
    "당신은 이전 대화의 기록을 참고하여서 저의 이름을 항상 기억합니다. 대화 주제는 자유롭습니다.", toolCalls: nil)]
    
    private let mapper: Mappable
    private var bindings = Set<AnyCancellable>()
    
    init(mapper: Mappable = Mapper(dataDecoder: DataDecoder(networkManager: NetworkManager()))) {
        self.mapper = mapper
    }
    
    func askQuestion(query: String, history: String) {
        fetchData(with: query, of: history)
    }
}

//네트워크 데이터 가져오는 부분
extension ChatRoomViewModel {
    private func fetchData(with question: String?, of history: String?) {
        state = .loading
        guard let question = question, let history = history else { return }
        
        self.comments.append(contentsOf: [ChatRoomModel(content: question, role: .user)])
        
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
            self?.comments.append(contentsOf: messages)
        }
    
        requestMessage.append(Message(role: .user, content: history, toolCalls: nil))
        
        mapper.mapChatGPTContent(with: requestMessage)
            .sink(receiveCompletion: questionCompletionHandler, receiveValue: questionValueHander)
            .store(in: &bindings)
    }
}
