//
//  MoveDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct MoveDTO: Decodable, Sendable {
    public let move: ListedItemDTO
    
    enum CodingKeys: String, CodingKey {
        case move
    }
}

extension MoveDTO {
    func toEntity() -> Move {
        return Move(move: move.toEntity())
    }
}

extension Array where Element == MoveDTO {
    func toEntity() -> [Move] {
        return self.map { $0.toEntity() }
    }
}

