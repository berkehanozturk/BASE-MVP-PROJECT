//
//  LoginModule.swift
//  Remote_Asset_Controller_iOS
//
//  Created by berkehan ozturk on 4.02.2023.
//

import UIKit

class LoginModule {
    
    static func initModule() -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController(Storyboards.login, LoginViewController.self) else {
            fatalError("Couldn't iniatialize LoginViewController from storyboard")
        }
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        return viewController
    }
    
}
