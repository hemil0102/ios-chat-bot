import Foundation
import Combine

final class ChatRoomCellViewModel {
    // 값이 변경되면 감지하는 옵저버를 달아준다.
    var contentMessage: String = ""
    var contentRole: Role = .user
        
    private let message: ChatRoomModel
    
    init(message: ChatRoomModel) {
        self.message = message
        
        setupBinding()
    }
    
    private func setupBinding() {
    //contentMessage가 message.content로부터 값을 받고 변경되었을 때 구독하는 곳에서 변화를 감지할 수 있을 것이다. 
        contentMessage = message.content
        contentRole = message.role
    }
}
