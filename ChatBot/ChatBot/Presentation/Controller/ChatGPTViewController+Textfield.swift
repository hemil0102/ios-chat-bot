//
//  ChatGPTViewController+Textfield.swift
//  ChatBot
//
//  Created by Harry Ho on 4/9/24.
//

import Foundation

//extension ChatGPTViewController {
//    override func loadView() {
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = .red
//        self.customTextField = CustomTextFieldView(frame: .zero)
//        
//        backgroundView.addSubview(self.customTextField)
//        self.customTextField.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//                    customTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
//                    customTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
//                    customTextField.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor), // 수정된 부분: safeAreaLayoutGuide 사용
//                ])
//        //self.view = customTextField
//        self.view = backgroundView
//    }
//}
//
//// Hide Keyboard
//extension ChatGPTViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatGPTViewController.dismissKeyboard))
//        // A Boolean value that determines whether touches are delivered to a view when a gesture is recognized.
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        // Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
//}
