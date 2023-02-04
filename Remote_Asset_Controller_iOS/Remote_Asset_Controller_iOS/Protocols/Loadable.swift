//
//  Loadable.swift
//  Application
//
//  Created by Berkehan on 4.01.2022.
//

import Foundation
import UIKit
protocol Loadable {
    func startLoading()
    func stopLoading()
    func startLoadingAtTargetView(view: UIView)
    func stopLoadingAtTargetView(view: UIView)
}

// Default protocol implementation for view controllers.
extension Loadable {

    func startLoading() {
        let loaderView = LoadingView()
        loaderView.setupLayout(targetView: UIApplication.shared.windows.first!)
    }

    func stopLoading() {
        let targetView = UIApplication.shared.windows.first!
        targetView.isUserInteractionEnabled = true
        for view in targetView.subviews where view is LoadingView {
            view.removeFromSuperview()
        }
    }
    
    func startLoadingAtTargetView(view: UIView) {
        let loaderView = LoadingView()
        loaderView.setupLayout(targetView: view)
    }
    
    func stopLoadingAtTargetView(view: UIView) {
        let targetView = view
        targetView.isUserInteractionEnabled = true
        for view in targetView.subviews where view is LoadingView {
            view.removeFromSuperview()
        }
    }
}
