//
//  Double+extensions.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation

extension Double {
    func metersToFeetAndInches() -> (feet: Int?, inches: Int) {
        let totalFeet = self * 3.28084
        let feet = Int(totalFeet)
        let inches = Int((totalFeet - Double(feet)) * 12)
        guard feet > 0 else { return (nil, inches) }
        return (feet, inches)
    }
    
    func kilogramsToPounds() -> Double {
        return ceil((self * 2.20462) * 10) / 10
    }
}


