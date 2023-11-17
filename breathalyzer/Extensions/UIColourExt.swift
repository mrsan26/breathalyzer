//
//  UIColourExt.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alfa: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alfa
        )
    }
}
