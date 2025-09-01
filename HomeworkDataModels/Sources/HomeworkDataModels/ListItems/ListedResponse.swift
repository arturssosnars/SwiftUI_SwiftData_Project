//
//  ListedResponse.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftData

public struct ListedResponseDTO: Decodable, Sendable {
    public let next: String?
    public let results: [ListedItemDTO]
    
    public init(next: String?, results: [ListedItemDTO]) {
        self.next = next
        self.results = results
    }
}

@Model
final public class ListedResponse {
    public var results: [ListedItem]
    public var hasNextPage: Bool
    public var limit: Int
    public var offset: Int
    
    public init(results: [ListedItem], hasNextPage: Bool, limit: Int, offset: Int) {
        self.results = results
        self.hasNextPage = hasNextPage
        self.limit = limit
        self.offset = offset
    }
}
