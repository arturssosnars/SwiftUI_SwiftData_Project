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

extension Move {
    func toDTO() -> MoveDTO {
        return MoveDTO(move: move.toDTO())
    }
}

extension Array where Element == Move {
    func toDTO() -> [MoveDTO] {
        return self.map { $0.toDTO() }
    }
    
    public func toList() -> [String] {
        return self.map { $0.move.name.capitalized }
    }
}
