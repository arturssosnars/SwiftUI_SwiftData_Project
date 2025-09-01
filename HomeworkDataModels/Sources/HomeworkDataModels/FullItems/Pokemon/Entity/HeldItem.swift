//
//  HeldItem.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class HeldItem {
    public var item: ListedItem
    
    public init(item: ListedItem) {
        self.item = item
    }
}

extension HeldItem {
    func toDTO() -> HeldItemDTO {
        return HeldItemDTO(item: item.toDTO())
    }
}

extension Array where Element == HeldItem {
    func toDTO() -> [HeldItemDTO] {
        return self.map { $0.toDTO() }
    }
}
