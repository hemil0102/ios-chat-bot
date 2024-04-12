import UIKit

final class ChatRoomView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var chattingTextField = UITextView()
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        
        return button
    }()
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        setupViews()
        hideKeyboardWhenTappedAround()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        textStackView.addArrangedSubview(chattingTextField)
        textStackView.addArrangedSubview(sendButton)
        
        let subviews = [collectionView, textStackView, activityIndicationView]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        chattingTextField.isUserInteractionEnabled = false
        collectionView.keyboardDismissMode = .interactive
        
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
            collectionView.bottomAnchor.constraint(equalTo: textStackView.topAnchor, constant: 20),
            textStackView.heightAnchor.constraint(equalToConstant: 40),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultMargin),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultMargin),
            textStackView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        
        chattingTextField.font = .preferredFont(forTextStyle: .body)
        chattingTextField.layer.borderWidth = 1
        chattingTextField.layer.borderColor = UIColor.gray.cgColor
        chattingTextField.layer.cornerRadius = 20
        chattingTextField.autocorrectionType = .no
        chattingTextField.backgroundColor = .systemBackground
//        chattingTextField.borderStyle = .roundedRect
//        chattingTextField.placeholder = "Please type something"
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

extension ChatRoomView {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
