//
//  Pokemon.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Pokemon {
    @Attribute(.unique) public var id: Int
    public var name: String
    public var stats: [Stat]
    public var isDefault: Bool
    public var locationAreaEncounters: String
    public var abilities: [Ability]
    public var baseExperience: Int
    public var cries: Cry
    public var forms: [ListedItem]
    public var height: Int
    public var weight: Int
    public var heldItems: [HeldItem]
    public var moves: [Move]
    public var sprites: Sprites
    
    public init(id: Int,
                name: String,
                stats: [Stat],
                isDefault: Bool,
                locationAreaEncounters: String,
                abilities: [Ability],
                baseExperience: Int,
                cries: Cry,
                forms: [ListedItem],
                height: Int,
                weight: Int,
                heldItems: [HeldItem],
                moves: [Move],
                sprites: Sprites) {
        self.id = id
        self.name = name
        self.stats = stats
        self.isDefault = isDefault
        self.locationAreaEncounters = locationAreaEncounters
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.cries = cries
        self.forms = forms
        self.height = height
        self.weight = weight
        self.heldItems = heldItems
        self.moves = moves
        self.sprites = sprites
    }
    
    public func setSpriteImages(frontDefault: Data?,
                         frontDefaultFemale: Data?,
                         frontShiny: Data?,
                         frontShinyFemale: Data?) {
        self.sprites.setSpriteImages(frontDefault: frontDefault,
                                     frontDefaultFemale: frontDefaultFemale,
                                     frontShiny: frontShiny,
                                     frontShinyFemale: frontShinyFemale)
    }
}
