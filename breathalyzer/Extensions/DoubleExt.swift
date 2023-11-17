//
//  DoubleExt.swift
//  breathalyzer
//
//  Created by Sanchez on 19.07.2023.
//

import Foundation

extension Double {
    func roundForSignsAfterDot(_ signs: Int) -> Double {
        var multiplier: Double = 1
        for _ in 1...signs {
            multiplier *= 10
        }
        return (self * multiplier).rounded() / multiplier
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toString() -> String {
        return String(self)
    }
    
    func checkMinus() -> Double {
        if self < 0 {
            return 0
        } else {
            return self
        }
    }
}

