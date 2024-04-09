import UIKit

class ChatBotRoomViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
//    struct ChatMessage: Hashable {
//        let content: String
//        let identifier = UUID()
//    }
    
    var chatBotRoomCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ChatBotRoomCollectionViewCell.Model>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        performQuery(with: nil)
    }
}

extension ChatBotRoomViewController {
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <ChatBotRoomCollectionViewCell, ChatBotRoomCollectionViewCell.Model> { (cell, indexPath, message) in
            // Populate the cell with our item description.
            cell.model = message
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ChatBotRoomCollectionViewCell.Model>(collectionView: chatBotRoomCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ChatBotRoomCollectionViewCell.Model) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    /// - Tag: MountainsPerformQuery
    func performQuery(with filter: String?) {
        let content = [ChatBotRoomCollectionViewCell.Model(message: "23asfafaefeaaf", chatType: .send)]

        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatBotRoomCollectionViewCell.Model>()
        snapshot.appendSections([.main])
        snapshot.appendItems(content)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ChatBotRoomViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            return section
        }
        return layout
    }

    func configureHierarchy() {
//        view.backgroundColor = .systemBlue
        chatBotRoomCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        chatBotRoomCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chatBotRoomCollectionView.backgroundColor = .blue
        view.addSubview(chatBotRoomCollectionView)

//        var constraints = [NSLayoutConstraint]()
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|[cv]|", options: [], metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|[searchBar]|", options: [], metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(
//            withVisualFormat: "V:[searchBar]-20-[cv]|", options: [], metrics: nil, views: views))
//        constraints.append(searchBar.topAnchor.constraint(
//            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0))
//        NSLayoutConstraint.activate(constraints)
//        mountainsCollectionView = collectionView
        //
//        searchBar.delegate = self
    }
}
