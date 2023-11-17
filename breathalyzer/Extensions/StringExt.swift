//
//  StringExt.swift
//  breathalyzer
//
//  Created by Sanchez on 17.07.2023.
//

import Foundation

extension String? {
    func toDouble() -> Double {
        return Double(self ?? "") ?? 0
    }
    
    func toInt() -> Int {
        return Int(self ?? "") ?? 0
    }
}
