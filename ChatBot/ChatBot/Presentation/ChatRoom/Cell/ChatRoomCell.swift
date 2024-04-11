import UIKit

final class ChatRoomCell: UICollectionViewListCell {
    static let identifier = "ChatRoomCell"
    
    var viewModel: ChatRoomCellViewModel! {
        didSet { setupViewModel() }
    }

    lazy var contentLabel = UILabel()
    lazy var chatBubble = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.removeFromSuperview()
        chatBubble.removeFromSuperview()
    }
    
    private func setupGPTConstraints() {
        chatBubble.backgroundColor = UIColor(named: "NormalPink")
        chatBubble.layer.cornerRadius = 10
        chatBubble.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chatBubble.addSubview(contentLabel)
        contentView.addSubview(chatBubble)

        NSLayoutConstraint.activate([
            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            chatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            chatBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            chatBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            contentLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupUserConstraints() {
        chatBubble.backgroundColor = UIColor(named: "SunshineYellow")
        chatBubble.layer.cornerRadius = 10
        chatBubble.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chatBubble.addSubview(contentLabel)
        contentView.addSubview(chatBubble)

        NSLayoutConstraint.activate([
            chatBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            chatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            chatBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            chatBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            contentLabel.topAnchor.constraint(equalTo: chatBubble.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: chatBubble.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: chatBubble.trailingAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupViewModel() {
        contentLabel.text = viewModel.contentMessage
        contentLabel.numberOfLines = 0
        let labelSize = contentLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        contentLabel.frame.size = labelSize
        
        if viewModel.contentRole == .user {
            setupUserConstraints()
        } else {
            setupGPTConstraints()
        }
    }
}
    
