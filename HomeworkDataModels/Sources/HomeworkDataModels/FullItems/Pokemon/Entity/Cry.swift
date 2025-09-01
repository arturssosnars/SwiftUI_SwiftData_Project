//
//  Cries.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Cry {
    public var latest: String
    
    public init(latest: String) {
        self.latest = latest
    }
}
