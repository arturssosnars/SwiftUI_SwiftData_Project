//
//  SpritesDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct SpritesDTO: Decodable, Sendable {
    public let frontDefault: String
    public let frontDefaultFemale: String?
    public let frontShiny: String
    public let frontShinyFemale: String?
    public var images: SpriteImagesDTO?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontDefaultFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    mutating func setSpriteImages(frontDefault: Data?,
                         frontDefaultFemale: Data?,
                         frontShiny: Data?,
                         frontShinyFemale: Data?) {
        self.images = SpriteImagesDTO(frontDefault: frontDefault,
                                           frontDefaultFemale: frontDefaultFemale,
                                           frontShiny: frontShiny,
                                           frontShinyFemale: frontShinyFemale)
    }
}

extension SpritesDTO {
    func toEntity() -> Sprites {
        Sprites(
            frontDefault: frontDefault,
            frontDefaultFemale: frontDefaultFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale,
            images: images?.toEntity()
        )
    }
}

public struct SpriteImagesDTO: Sendable {
    public let frontDefault: Data?
    public let frontDefaultFemale: Data?
    public let frontShiny: Data?
    public let frontShinyFemale: Data?
    
    public init(frontDefault: Data?,
                frontDefaultFemale: Data?,
                frontShiny: Data?,
                frontShinyFemale: Data?) {
        self.frontDefault = frontDefault
        self.frontDefaultFemale = frontDefaultFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
    
    func toEntity() -> SpriteImages? {
        SpriteImages(frontDefault: frontDefault,
                     frontDefaultFemale: frontDefaultFemale,
                     frontShiny: frontShiny,
                     frontShinyFemale: frontShinyFemale)
    }
}
