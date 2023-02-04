//
//  nibLoadedView.swift
//  Application
//
//  Created by Berkehan on 29.11.2021.
//

import Foundation
import UIKit
public protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
