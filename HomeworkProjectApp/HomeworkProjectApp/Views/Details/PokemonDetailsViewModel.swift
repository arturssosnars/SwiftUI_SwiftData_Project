//
//  PokemonDetailsViewModel.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 01/09/2025.
//

import SwiftUI
import SwiftData
import HomeworkDataModels

class PokemonDetailsViewModel: ObservableObject {
    @Published public var pokemon: Pokemon?
    @Published public var hasEncounteredError: Bool = false
    
    func updateIfExisting(pokemon: Pokemon, using modelContext: ModelContext) throws {
        if let pokemon = fetchLocalData(for: pokemon.id, using: modelContext) {
            var bindable: Bindable<Pokemon> = Bindable<Pokemon>(wrappedValue: pokemon)
            bindable.wrappedValue = pokemon
            try modelContext.save()
        } else {
            modelContext.insert(pokemon)
            try modelContext.save()
        }
    }
    
    func fetchLocalData(for id: Int, using modelContext: ModelContext) -> Pokemon? {
        let descriptor = FetchDescriptor<Pokemon>(
            predicate: #Predicate<Pokemon> {
                $0.id == id
            }
        )
        let localItem = try? modelContext.fetch(descriptor)
        guard let item = localItem?.first else { return nil }
        return item
    }
    
    @MainActor
    func fetchData(for id: Int, using modelContext: ModelContext) async {
        do {
            let pokemon = try await DataFetcher.shared.fetchPokemon(id: id)
            self.pokemon = pokemon.toEntity()
            try updateIfExisting(pokemon: pokemon.toEntity(), using: modelContext)
        } catch {
            hasEncounteredError = true
        }
    }
}
