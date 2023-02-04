//
//  LoadingView.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 26.12.2022.
//

import Foundation
import UIKit

public class LoadingView: UIView {

    private let img = UIImageView(image: UIImage(named: ImageNames.myLoader))
    public init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        return backgroundView
    }()

    public func setupLayout(targetView: UIView) {

        targetView.isUserInteractionEnabled = false
        targetView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: targetView.frame.size.width).isActive = false
        self.heightAnchor.constraint(equalToConstant: targetView.frame.size.height).isActive = false
        self.centerYAnchor.constraint(equalTo: targetView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: targetView.centerXAnchor).isActive = true

        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: targetView.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor).isActive = true

        setupImageLayout()
        startAnimating()
    }

    private func setupImageLayout() {
        img.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(img)
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    private func startAnimating() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                       animations: {
                        self.img.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: nil)
    }
}
