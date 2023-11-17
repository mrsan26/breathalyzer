//
//  ProfileCell.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import UIKit

class ProfileCell: BasicCell {

    static let id = String(describing: ProfileCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(profile: UserProfile) {
        nameLabel.text = profile.name
        heightLabel.text = "Рост: \(profile.height)"
        weightLabel.text = "Вес: \(profile.weight)"
    }
    
}
