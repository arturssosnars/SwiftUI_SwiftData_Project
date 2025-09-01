//
//  Destinations.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation
import SwiftUI

enum Destination: Codable, Hashable {
    case pokemon(id: Int)
    
    @ViewBuilder
    static func view(for destination: Destination) -> some View {
        switch destination {
        case .pokemon(let id):
            PokemonDetailsView(id: id)
        }
    }
}
