import UIKit
import Combine

final class ChatGPTViewController: UIViewController {
    
    //MARK: Properties
    private var cancellables = Set<AnyCancellable>()
    private let usecase: ChatGPTUseCaseProtocol = ChatGPTUseCase(mapper: Mapper(dataDecoder: DataDecoder(networkManager: NetworkManager())))
    private let messages = [
        Message(role: .system, content: "안녕 너는 나와 아무 주제에 대해서 이야기할텐데, 나의 이름을 대화 내내 기억해야해, 답변은 30글자 내로 해줘", toolCalls: nil),
        Message(role: .user, content: "안녕 나의 이름은 Harry야, Jin 그리고 July와 함께 챗봇을 만드는 중이야! 마지막 프로젝트인데 어렵고 넘모 힘들다~ 웅우엉웅웡",
                toolCalls: nil)
    ]
    
    //MARK: Views
    private var collectionView: UICollectionView!
    
    private var chatGPTCollectionView: ChatGPTCollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ChatDisplayModel>!
    private var cellRegistration: UICollectionView.CellRegistration<ChatBubbleCell, ChatDisplayModel>!
    private var contents = [ChatDisplayModel(content: "test")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printUserQuestion(with: messages[1].content)
        printChatGPTAnswer(with: messages)
        setupUI()
        configureDataSource()
        applySnapshot(content: contents, animatingDifferences: true)
    }
    
    override func loadView() {
        self.chatGPTCollectionView = ChatGPTCollectionView(frame: .zero)
        self.view = chatGPTCollectionView
    }
    
    private func printUserQuestion(with question: String) {
        print("Harry: \(question)")
    }
    
    private func printChatGPTAnswer(with messages: [Message]) {
        usecase.fetchChatGPTContent(with: messages)
            .sink { completion in
                print(completion)
            } receiveValue: { value in
                print(value.content)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Apply Diffable DataSource
private extension ChatGPTViewController {
    func setupUI() {
        configureCellRegistration()
    }
    
    func configureCellRegistration() {
        cellRegistration = UICollectionView.CellRegistration<ChatBubbleCell, ChatDisplayModel> { (cell, indexPath, chat) in
            cell.contentLabel.text = chat.content
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ChatDisplayModel>(collectionView: chatGPTCollectionView) {
            (collectionView, indexPath, chat) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: chat)
        }
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, ChatDisplayModel>()
        initialSnapshot.appendSections([.main])
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func applySnapshot(content: [ChatDisplayModel], animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatDisplayModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(content, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}


