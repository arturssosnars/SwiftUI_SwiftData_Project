//
//  ListedItem.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

@Model
public class ListedItem {
    public var name: String
    public var id: Int?
    
    public init(name: String, id: Int?) {
        self.name = name
        self.id = id
    }
}

extension ListedItem {
    func toDTO() -> ListedItemDTO {
        return ListedItemDTO(name: name, id: id)
    }
}

extension Array where Element == ListedItem {
    public func toDTO() -> [ListedItemDTO] {
        return self.map { $0.toDTO() }
    }
    
    public func toList() -> [String] {
        return self.map { $0.name.capitalized }
    }
}
