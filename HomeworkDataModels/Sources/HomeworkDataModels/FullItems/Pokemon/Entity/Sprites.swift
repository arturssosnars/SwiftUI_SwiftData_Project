//
//  Sprites.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Sprites {
    public var frontDefault: String
    public var frontDefaultFemale: String?
    public var frontShiny: String
    public var frontShinyFemale: String?
    public var images: SpriteImages?
    
    public init(frontDefault: String,
                frontDefaultFemale: String?,
                frontShiny: String,
                frontShinyFemale: String?,
                images: SpriteImages?) {
        self.frontDefault = frontDefault
        self.frontDefaultFemale = frontDefaultFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.images = images
    }
    
    func setSpriteImages(frontDefault: Data?,
                         frontDefaultFemale: Data?,
                         frontShiny: Data?,
                         frontShinyFemale: Data?) {
        self.images = SpriteImages(frontDefault: frontDefault,
                                           frontDefaultFemale: frontDefaultFemale,
                                           frontShiny: frontShiny,
                                           frontShinyFemale: frontShinyFemale)
    }
}

extension Sprites {
    func toDTO() -> SpritesDTO {
        SpritesDTO(
            frontDefault: frontDefault,
            frontDefaultFemale: frontDefaultFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale,
            images: images?.toDTO()
        )
    }
}

@Model
public class SpriteImages {
    @Attribute(.externalStorage) public var frontDefault: Data?
    @Attribute(.externalStorage) public var frontDefaultFemale: Data?
    @Attribute(.externalStorage) public var frontShiny: Data?
    @Attribute(.externalStorage) public var frontShinyFemale: Data?
    
    public init(frontDefault: Data?,
                frontDefaultFemale: Data?,
                frontShiny: Data?,
                frontShinyFemale: Data?) {
        self.frontDefault = frontDefault
        self.frontDefaultFemale = frontDefaultFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
    
    func toDTO() -> SpriteImagesDTO {
        SpriteImagesDTO(
            frontDefault: frontDefault,
            frontDefaultFemale: frontDefaultFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale
        )
    }
}
