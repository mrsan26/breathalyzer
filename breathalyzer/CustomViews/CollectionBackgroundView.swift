//
//  CollectionBackgroundView.swift
//  breathalyzer
//
//  Created by Sanchez on 31.07.2023.
//

import Foundation
import UIKit

class CollectionBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor(red: 175, green: 218, blue: 254)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
