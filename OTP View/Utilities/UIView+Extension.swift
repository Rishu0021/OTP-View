//
//  UIView+Extension.swift
//  OTP View
//
//  Created by Rishu Gupta on 20/07/20.
//

import UIKit

extension UIView {
    func addShadow(offset: CGSize = CGSize.zero, color: UIColor = .gray, opacity: Float = 0.3, radius: CGFloat = 10.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }

}
