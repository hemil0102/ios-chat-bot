import UIKit

final class ChatRoomCell: UICollectionViewListCell {
    static let identifier = "ChatRoomCell"
    
    var viewModel: ChatRoomCellViewModel! {
        didSet { setupViewModel() }
    }

    lazy var contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.9, alpha: 1.0)
        backgroundView.layer.cornerRadius = 10
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(contentLabel)
        contentView.addSubview(backgroundView)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            contentLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupViewModel() {
        contentLabel.text = viewModel.contentMessage
        contentLabel.numberOfLines = 0
        let labelSize = contentLabel.sizeThatFits(CGSize(width: contentView.bounds.width - 60, height: CGFloat.greatestFiniteMagnitude))
        contentLabel.frame.size = labelSize
        setupConstraints()
    }
}
    
