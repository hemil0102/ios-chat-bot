import UIKit

final class ChatRoomView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var chattingTextField = UITextField()
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let subviews = [collectionView, chattingTextField, activityIndicationView]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        chattingTextField.isUserInteractionEnabled = false
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        chattingTextField.isUserInteractionEnabled = true
    
        activityIndicationView.stopAnimating()
    }
    
    private func setupConstraints() {
        let defaultMargin: CGFloat = 4.0
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: defaultMargin),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: chattingTextField.topAnchor, constant: 20),
            chattingTextField.heightAnchor.constraint(equalToConstant: 40),
            chattingTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultMargin),
            chattingTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            chattingTextField.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        
        chattingTextField.autocorrectionType = .no
        chattingTextField.backgroundColor = .systemBackground
        chattingTextField.borderStyle = .roundedRect
        chattingTextField.placeholder = "Please type something"
    }

    //UICollectionLayoutListConfiguration 다시 보고 list 형식으로 구현
    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.interGroupSpacing = 5
        return UICollectionViewCompositionalLayout(section: section)
    }
}


