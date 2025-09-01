//
//  ListType.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation

public enum ListType: String, Identifiable {
    case pokemon, test, test2
    
    public var id: String {
        return self.rawValue
    }
    
    public var title: String {
        switch self {
        case .pokemon:
            return "Pokedex"
        case .test, .test2:
            return "Test"
        }
    }
    
    public var imageName: String {
        switch self {
        case .pokemon, .test, .test2:
            return "pokemon_icon"
        }
    }
    
    public var imageNameSelected: String {
        switch self {
        case .pokemon, .test, .test2:
            return "pokemon_icon_selected"
        }
    }
}
