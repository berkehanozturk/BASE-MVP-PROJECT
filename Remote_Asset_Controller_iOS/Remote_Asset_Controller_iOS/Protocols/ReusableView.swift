//
//  ReusableView.swift
//  Application
//
//  Created by Berkehan on 29.11.2021.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}
extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
