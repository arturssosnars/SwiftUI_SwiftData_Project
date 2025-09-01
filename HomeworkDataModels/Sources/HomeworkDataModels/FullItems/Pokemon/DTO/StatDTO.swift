//
//  StatDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct StatDTO: Decodable, Sendable {
    public let baseStat: Int
    public let effort: Int
    public let stat: ListedItemDTO
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

extension StatDTO {
    func toEntity() -> Stat {
        return Stat(baseStat: baseStat,
                    effort: effort,
                    stat: stat.toEntity())
    }
}

extension Array where Element == StatDTO {
    func toEntity() -> [Stat] {
        return self.map { $0.toEntity() }
    }
}

