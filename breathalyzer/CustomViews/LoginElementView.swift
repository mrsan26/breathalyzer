//
//  LoginElementView.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor(red: 235, green: 248, blue: 255)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 3.0
    }
    
}
