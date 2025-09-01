//
//  AbilityDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct AbilityDTO: Decodable, Sendable {
    public let ability: ListedItemDTO
    public let isHidden: Bool
    public let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

extension AbilityDTO {
    func toEntity() -> Ability {
        return Ability(ability: ability.toEntity(),
                       isHidden: isHidden,
                       slot: slot)
    }
}

extension Array where Element == AbilityDTO {
    func toEntity() -> [Ability] {
        self.map { $0.toEntity() }
    }
}

