//
//  Ability.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Ability {
    public var ability: ListedItem
    public var isHidden: Bool
    public var slot: Int
    
    public init(ability: ListedItem,
                isHidden: Bool,
                slot: Int) {
        self.ability = ability
        self.isHidden = isHidden
        self.slot = slot
    }
}

extension Array where Element == Ability {
    public func toList() -> [String] {
        var list: [String] = []
        for ability in self {
            list.append(ability.ability.name.capitalized)
        }
        return list
    }
}
