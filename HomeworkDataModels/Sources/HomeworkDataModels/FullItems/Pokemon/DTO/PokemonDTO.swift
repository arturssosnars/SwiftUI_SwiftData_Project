//
//  PokemonDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct PokemonDTO: Decodable, Sendable {
    public let id: Int
    public let name: String
    public let stats: [StatDTO]
    public let isDefault: Bool
    public let locationAreaEncounters: String
    public let abilities: [AbilityDTO]
    public let baseExperience: Int
    public let cries: CryDTO
    public let forms: [ListedItemDTO]
    public let height: Int
    public let weight: Int
    public let heldItems: [HeldItemDTO]
    public let moves: [MoveDTO]
    public var sprites: SpritesDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stats
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case abilities
        case baseExperience = "base_experience"
        case cries
        case forms
        case height
        case weight
        case heldItems = "held_items"
        case moves
        case sprites
    }
    
    public mutating func setSpriteImages(frontDefault: Data?,
                         frontDefaultFemale: Data?,
                         frontShiny: Data?,
                         frontShinyFemale: Data?) {
        self.sprites.setSpriteImages(frontDefault: frontDefault,
                                     frontDefaultFemale: frontDefaultFemale,
                                     frontShiny: frontShiny,
                                     frontShinyFemale: frontShinyFemale)
    }
}

extension PokemonDTO {
    public func toEntity() -> Pokemon {
        return Pokemon(
            id: id,
            name: name,
            stats: stats.toEntity(),
            isDefault: isDefault,
            locationAreaEncounters: locationAreaEncounters,
            abilities: abilities.toEntity(),
            baseExperience: baseExperience,
            cries: cries.toEntity(),
            forms: forms.toEntity(),
            height: height,
            weight: weight,
            heldItems: heldItems.toEntity(),
            moves: moves.toEntity(),
            sprites: sprites.toEntity())
    }
}
