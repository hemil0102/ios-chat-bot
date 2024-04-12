import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        // 텍스트 에디팅이 끝나면 -> send 버튼이 눌리면
        NotificationCenter.default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
}
