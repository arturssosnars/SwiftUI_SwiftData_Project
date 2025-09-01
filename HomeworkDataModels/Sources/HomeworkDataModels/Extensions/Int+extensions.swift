//
//  Int+extensions.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation

extension Int {
    public var weightString: String {
        let kg = Double(self) / 10
        return "\(kg)kg (\(kg.kilogramsToPounds())lbs)"
    }
    
    public var heightString: String {
        let meters = Double(self) / 10
        let (feet, inch) = meters.metersToFeetAndInches()
        
        if let feet {
            return "\(meters)m (\(feet)'\(inch)\")"
        }
        return "\(meters)m (\(inch)\")"
    }
}
