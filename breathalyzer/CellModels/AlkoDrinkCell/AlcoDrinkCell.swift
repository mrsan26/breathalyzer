//
//  AlcoDrinkCell.swift
//  breathalyzer
//
//  Created by Sanchez on 31.07.2023.
//

import UIKit

class AlcoDrinkCell: UICollectionViewCell {

    static let id = String(describing: AlcoDrinkCell.self)
    
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(alkoDrink: AlkoDrinkModel) {
        degreeLabel.text = "\(alkoDrink.degree)°"
        amountLabel.text = "\(alkoDrink.amount) мл"
    }

}
