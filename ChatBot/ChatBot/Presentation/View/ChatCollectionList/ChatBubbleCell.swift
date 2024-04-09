
import UIKit

final class ChatBubbleCell: UICollectionViewListCell {
    var contentLabel = UILabel()
    
    private let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatBubbleCell {
    private func configureLayout() {
        configureSeparatorView()
        configureContentLabel()
    }
  
    private func configureContentLabel() {
        addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func configureSeparatorView() {
        addSubview(separatorView)
        
        separatorView.backgroundColor = .opaqueSeparator
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 0.3),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
