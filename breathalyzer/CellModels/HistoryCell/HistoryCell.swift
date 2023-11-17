//
//  HistoryCell.swift
//  breathalyzer
//
//  Created by Sanchez on 26.07.2023.
//

import UIKit

class HistoryCell: BasicCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alkoInBloodLabel: UILabel!
    @IBOutlet weak var dateSobrietyLabel: UILabel!
    @IBOutlet weak var dateOfCountingLabel: UILabel!
    
    static let id = String(describing: HistoryCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(results: ResultsModel) {
        nameLabel.text = results.profileName
        alkoInBloodLabel.text = "\(results.alkoInBlood) ‰"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        dateSobrietyLabel.text = "Время вытрезвления: \(dateFormatter.string(from: results.dateSobriety))"
        dateOfCountingLabel.text = "Дата вычисления: \(dateFormatter.string(from: results.dateOfCounting))"
    }
    
}
