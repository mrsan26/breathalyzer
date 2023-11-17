//
//  IntExt.swift
//  breathalyzer
//
//  Created by Sanchez on 18.07.2023.
//

import Foundation

extension Int {
    func toDouble() -> Double {
        return Double(self) 
    }
    
    func toString() -> String {
        return String(self)
    }
    
    func checkMinus() -> Int {
        if self < 0 {
            return 0
        } else {
            return self
        }
    }
}


