//
//  UIViewExt.swift
//  breathalyzer
//
//  Created by Sanchez on 17.07.2023.
//

import Foundation
import UIKit

extension UIView {
    func shakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            NSValue(cgPoint: CGPoint(x: center.x - 8, y: center.y)),
            NSValue(cgPoint: CGPoint(x: center.x + 8, y: center.y)),
            NSValue(cgPoint: CGPoint(x: center.x - 8, y: center.y)),
            NSValue(cgPoint: CGPoint(x: center.x , y: center.y))
        ]
        animation.timingFunctions = [
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut),
            CAMediaTimingFunction(name: .easeInEaseOut)
        ]
        animation.duration = 0.3
        layer.add(animation, forKey: "shake")
    }
}
