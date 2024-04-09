//
//  ChatBotRoomCollectionViewCell.swift
//  ChatBot
//
//  Created by Jin-Mac on 4/9/24.
//

import UIKit

class ChatBotRoomCollectionViewCell: UICollectionViewCell {
    enum ChatType: CaseIterable {
        case receive
        case send
    }
    
    struct Model: Hashable {
        let identifier = UUID()
        var message: String
        let chatType: ChatType
    }
    
    var model: Model? {
        didSet { bind() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let messaageTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 18.0)
        view.text = "Sample message"
        view.textColor = .black
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.0
        view.layer.masksToBounds = false
        view.isEditable = false
        return view
    }()
    
    func setupViews() {
        
        contentView.addSubview(messaageTextView)
        messaageTextView.translatesAutoresizingMaskIntoConstraints = false
        messaageTextView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        messaageTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func bind() {
        guard let model = model, let font = messaageTextView.font else {
            return
        }
        messaageTextView.text = model.message
        let estimatedFrame = model.message.getEstimatedFrame(with: font)
        
        messaageTextView.widthAnchor.constraint(equalToConstant: estimatedFrame.width + 16).isActive = true
        
        if case .receive = model.chatType {
            messaageTextView.backgroundColor = .systemBlue
            messaageTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            messaageTextView.addTipViewToRightBottom(with: messaageTextView.backgroundColor)
        } else {
            messaageTextView.backgroundColor = .white
            messaageTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            messaageTextView.addTipViewToLeftTop(with: messaageTextView.backgroundColor)
        }
    }
}
