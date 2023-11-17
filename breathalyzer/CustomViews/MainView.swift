//
//  MainView.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import Foundation
import UIKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor(red: 204, green: 235, blue: 255)
    }
    
}
