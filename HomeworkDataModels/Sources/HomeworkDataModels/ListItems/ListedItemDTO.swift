//
//  ListedItemDTO.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct ListedItemDTO: Decodable, Sendable {
    public var name: String
    public var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let url = try container.decode(String.self, forKey: .url)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = ListedItemDTO.entryID(from: url)
    }
    
    init(name: String, id: Int?) {
        self.name = name
        self.id = id
    }
}

extension ListedItemDTO {
    func toEntity() -> ListedItem {
        return ListedItem(name: name, id: id)
    }
}

extension Array where Element == ListedItemDTO {
    public func toEntity() -> [ListedItem] {
        return self.map { $0.toEntity() }
    }
}

extension ListedItemDTO {
    fileprivate static func entryID(from url: String) -> Int? {
        let baseURLString = "https://pokeapi.co/api/v2/"
        let trimmed = url.replacingOccurrences(of: baseURLString, with: "")
        let pattern = "\\d+"
        if let match = trimmed.range(of: pattern, options: .regularExpression) {
            let numberString = String(trimmed[match])
            if let number = Int(numberString) {
                return number
            }
        }
        return nil
    }
}
