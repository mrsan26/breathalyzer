//
//  BasicCell.swift
//  breathalyzer
//
//  Created by Sanchez on 26.07.2023.
//

import UIKit

class BasicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(red: 235, green: 248, blue: 255)
    }

}
