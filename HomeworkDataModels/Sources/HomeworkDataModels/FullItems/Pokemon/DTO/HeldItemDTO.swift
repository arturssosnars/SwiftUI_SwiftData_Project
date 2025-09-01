//
//  HeldItem.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct HeldItemDTO: Decodable, Sendable {
    public let item: ListedItemDTO
    
    enum CodingKeys: String, CodingKey {
        case item
    }
    
    init(item: ListedItemDTO) {
        self.item = item
    }
}

extension HeldItemDTO {
    func toEntity() -> HeldItem {
        return HeldItem(item: item.toEntity())
    }
}

extension Array where Element == HeldItemDTO {
    func toEntity() -> [HeldItem] {
        return self.map { $0.toEntity() }
    }
}
