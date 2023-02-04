//
//  BackButton.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 26.12.2022.
//

import Foundation
import UIKit

public class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupButton() {
        setBackgroundImage(UIImage(named: ImageNames.backButton), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
