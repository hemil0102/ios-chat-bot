import UIKit
import Combine

final class ChatGPTViewController: UIViewController {
    
    var networkManager: Fetchable = NetworkManager()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchData()
            .decode(type: GPTResponseDTO.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { print("안녕?: \($0)") }, receiveValue: { print("디코딩된 값 \($0)") })
            .store(in: &cancellables)
    }
}
