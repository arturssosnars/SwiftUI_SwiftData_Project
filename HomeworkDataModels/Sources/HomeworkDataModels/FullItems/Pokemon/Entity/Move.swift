//
//  Move.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class Move {
    public var move: ListedItem
    
    public init(move: ListedItem) {
        self.move = move
    }
}

extension Array where Element == Move {
    public func toList() -> [String] {
        return self.map { $0.move.name.capitalized }
    }
}
