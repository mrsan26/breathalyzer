//
//  ResultsModel.swift
//  breathalyzer
//
//  Created by Sanchez on 19.07.2023.
//

import Foundation
import RealmSwift

class ResultsModel: Object {
    @Persisted var profileName: String
    @Persisted var alkoInBlood: Double // промили
    @Persisted var alkoInBreath: Double // мг\л
    @Persisted var removeTimeHours: Int // час
    @Persisted var removeTimeMinutes: Int // мин
    @Persisted var dateSobriety: Date // дата трезвления
    @Persisted var dateOfCounting: Date // дата вычисления
    
    
    convenience init(profileName: String, alkoInBlood: Double, alkoInBreath: Double, removeTimeHours: Int, removeTimeMinutes: Int, dateSobriety: Date, dateOfCounting: Date) {
        self.init()
        self.profileName = profileName
        self.alkoInBlood = alkoInBlood
        self.alkoInBreath = alkoInBreath
        self.removeTimeHours = removeTimeHours
        self.removeTimeMinutes = removeTimeMinutes
        self.dateSobriety = dateSobriety
        self.dateOfCounting = dateOfCounting
    }
}
