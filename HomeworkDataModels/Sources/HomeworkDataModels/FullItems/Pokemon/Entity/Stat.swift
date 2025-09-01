//
//  Stat.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Stat {
    public var baseStat: Int
    public var effort: Int
    public var stat: ListedItem
    
    public init(baseStat: Int,
                effort: Int,
                stat: ListedItem) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
}

extension Stat {
    func toDTO() -> StatDTO {
        return StatDTO(baseStat: baseStat,
                       effort: effort,
                       stat: stat.toDTO())
    }
}

extension Array where Element == Stat {
    func toDTO() -> [StatDTO] {
        return self.map { $0.toDTO() }
    }
    
    public func toList() -> [String: Int] {
        var stats: [String: Int] = [:]
        self.forEach { stats[$0.stat.name] = $0.baseStat }
        return stats
    }
}
