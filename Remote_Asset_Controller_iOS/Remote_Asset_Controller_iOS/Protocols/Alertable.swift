//
//  Alertable.swift
//  Application
//
//  Created by Berkehan on 26.11.2021.
//

import UIKit

protocol Alertable {
    func showAlert(title: String, message: String, actions: [UIAlertAction]?)
}

// Default protocol implementation for view controllers.
extension Alertable where Self: UIViewController {

    /// Function to show alert across the app.
    /// - Parameter title: The title of the alert dialog. You dont have to write the title explicitly. Default title is "Oops.."
    /// - Parameter message: The message of the alert dialog.
    /// - Parameter actions: An array of UIAlertActions. Each UIAlertAction will be appeared as buttons in the alert dialog with their respective actions. Set to nil by default so you dont have to specify nill explicitly.
    /// - Warning: A default action (Button) will be added to close the alert dialog automaticaly.

    func showAlert(title: String = "Oops..", message: String = "", actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        alert.view.layoutIfNeeded()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        present(alert, animated: true, completion: nil)
    }

}
