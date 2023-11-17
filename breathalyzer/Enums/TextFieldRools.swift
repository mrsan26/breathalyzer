//
//  TextFieldRools.swift
//  breathalyzer
//
//  Created by Sanchez on 17.07.2023.
//

import Foundation

enum TextFieldRools {
    case weight
    case height
    case amount
    case degree
    
    var from: Int {
        switch self {
        case .weight:
            return 30
        case .height:
            return 100
        case .amount:
            return 50
        case .degree:
            return 1
        }
    }
    
    var to: Int {
        switch self {
        case .weight:
            return 200
        case .height:
            return 250
        case .amount:
            return 10000
        case .degree:
            return 96
        }
    }
    
    var correctInfo: String {
        switch self {
        case .weight:
            return "30 - 200 кг"
        case .height:
            return "100 - 250 см"
        case .amount:
            return "50 - 10000 мл"
        case .degree:
            return "1 - 96 градусов"
        }
    }
    
    var defaultPlaceholder: String {
        switch self {
        case .weight:
            return "килограммы"
        case .height:
            return "сантиметры"
        case .amount:
            return "миллилитры"
        case .degree:
            return "градусы"
        }
    }
    
}
