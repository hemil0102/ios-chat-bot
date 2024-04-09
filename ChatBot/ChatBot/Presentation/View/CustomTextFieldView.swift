import UIKit

class CustomTextFieldView: UIView {

    var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        self.addSubview(textField)
        constraintCustomeView()
    }
    
    private func constraintCustomeView() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor, constant: -10).isActive = true
    }
    
    @objc func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
}
