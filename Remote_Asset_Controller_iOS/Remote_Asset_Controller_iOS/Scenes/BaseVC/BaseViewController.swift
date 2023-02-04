//
//  BaseViewController.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 26.12.2022.
//

import UIKit
protocol BaseRouter: AnyObject {
  
}

protocol BaseView: AnyObject, Alertable, Loadable where Self: BaseViewController {
    
}

class BaseViewController: UIViewController, Alertable {
    var backButton: BackButton?
    var bottomConstraintForKeyboard: NSLayoutConstraint?
    var keyboardHeight: CGFloat?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
  
    }
    
    func registerForKeyboardNotifications(bottomConstraint: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
        name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide),
        name: UIResponder.keyboardWillHideNotification, object: nil)
        bottomConstraintForKeyboard = bottomConstraint
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            if let bottomConstraint = bottomConstraintForKeyboard {
                bottomConstraint.constant = -keyboardSize.height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if let bottomConstraint = bottomConstraintForKeyboard {
            bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
