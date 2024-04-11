import UIKit
import Combine

final class ChatRoomViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ChatRoomModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoomModel>
    
    private lazy var contentView = ChatRoomView()
    private let viewModel: ChatRoomViewModel
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource!
    private var history: String = ""
    private var count: Int = 0
    
    init(viewModel: ChatRoomViewModel = ChatRoomViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "NormalPink")
        contentView.chattingTextField.delegate = self
        setupTableView()
        configureDataSource()
        setupBindings()
    }
    
    //셀 등록해주기
    private func setupTableView() {
        contentView.collectionView.register(ChatRoomCell.self, forCellWithReuseIdentifier: ChatRoomCell.identifier)
        contentView.collectionView.allowsSelection = false
    }
    
    private func setupBindings() {
        func bindViewToViewModel() {
            contentView.chattingTextField.textPublisher
                .debounce(for: 0.5, scheduler: RunLoop.main) // 이게 뭔지 공부하자
                .removeDuplicates()
                .sink { [weak self] query in
                    guard let self = self else { return }
                    history += "UserQuestion\(count): \(query)" + " "
                    print("히스토리: \(history)")
                    viewModel.askQuestion(query: query, history: history)
                }
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            viewModel.$comments
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] answer in
                    guard let self = self else { return }
                    if !answer.isEmpty {
                          history += "GPTAnswer\(count): \(answer[0].content)" + " "
                          print("답변: \(history)")
                          self.count += 1
                          print("카운트: \(count)")
                          self.updateSections()
                    }
                })
                .store(in: &bindings)
            
            let stateValueHandler: (ChatRoomModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.startLoading()
                case .finishedLoading:
                    self?.contentView.finishLoading()
                case .error(let error):
                    self?.contentView.finishLoading()
                    self?.showError(error)
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.chat])
        snapshot.appendItems(viewModel.comments)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ChatRoomViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, message) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ChatRoomCell.identifier,
                    for: indexPath) as? ChatRoomCell
                cell?.viewModel = ChatRoomCellViewModel(message: message)
                return cell
            })
    }
}

extension ChatRoomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.chattingTextField.resignFirstResponder()
        contentView.chattingTextField.text = ""
        return true
    }
}
