//
//  TextFieldCustom.swift
//  breathalyzer
//
//  Created by Sanchez on 01.08.2023.
//

import Foundation
import UIKit

class TextFieldCustom: UITextField {
    
    var needToCheckup: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
    }
    
}
