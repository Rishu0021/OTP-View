//
//  UIStackView+Extension.swift
//  OTP View
//
//  Created by Rishu Gupta on 20/07/20.
//

import UIKit

extension UIStackView {
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
