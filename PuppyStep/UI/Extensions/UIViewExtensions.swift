//
//  UIViewExtensions.swift
//  PuppyStep
//
//  Created by Sergey on 17.12.20.
//

import Foundation
import UIKit

extension UIView {
    func roundBottomCorners(cornerRadius: Double) {
        layer.cornerRadius = CGFloat(cornerRadius)
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func roundTopCorners(cornerRadius: Double) {
        layer.cornerRadius = CGFloat(cornerRadius)
        clipsToBounds = true
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
