import UIKit
import Combine
// 컨벤션 수정, 함수명, 접근제어 잊지 말자

final class ChatGPTViewController: UIViewController {
    var networkManager: Fetchable = NetworkManager()
    var cancellables = Set<AnyCancellable>()
    var messages = [Message(role: .system, content: "안녕 너는 나와 아무 주제에 대해서 이야기할텐데, 나의 이름을 대화 내내 기억해야해, 답변은 30글자 내로 해줘", toolCalls: nil), Message(role: .user, content: "안녕 나의 이름은 Harry야, Jin 그리고 July와 함께 챗봇을 만드는 중이야! 마지막 프로젝트인데 어렵고 넘모 힘들다~ 웅우엉웅웡", toolCalls: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printUserQuestion(with: messages[1].content)
        printChatGPTData(with: messages)
    }
    
    func printUserQuestion(with question: String) {
        print("Harry: \(question)")
    }
    
    func printChatGPTData(with messages: [Message]) {
        networkManager.fetchChatGPTCompletionData(type: GPTResponseDTO.self, with: messages)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    print(result)
                }
            }, receiveValue: { print("ChatGPT: \($0.choices[0].message.content)") })
            .store(in: &cancellables)
    }
}
