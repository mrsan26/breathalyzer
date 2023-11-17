//
//  ProfileModel.swift
//  breathalyzer
//
//  Created by Sanchez on 24.07.2023.
//

import Foundation
import RealmSwift

class UserProfile: Object {
    @Persisted var name: String
    @Persisted var weight: Int
    @Persisted var height: Int
    @Persisted var sex: Int
    @Persisted var ID: Int
    
    convenience init(name: String, weight: Int, height: Int, sex: Int, ID: Int) {
        self.init()
        self.name = name
        self.weight = weight
        self.height = height
        self.sex = sex
        self.ID = ID
    }
}
