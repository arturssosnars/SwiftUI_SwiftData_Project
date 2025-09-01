//
//  DataFetcher.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import Foundation
import SwiftUI
import HomeworkDataFetcher
import HomeworkDataModels

enum DataFetcherError: Error {
    case noSwiftDataFetcher
}

class DataFetcher {
    static let shared = DataFetcher()
    let networkFetcher = NetworkFetcher()
    
    private init() {}
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> ListedResponseDTO {
        return try await networkFetcher.fetchPokemonList(
            limit: limit,
            offset: offset)
    }
    
    func fetchPokemon(id: Int) async throws -> PokemonDTO {
        return try await networkFetcher.fetchPokemon(id: id)
    }
}
