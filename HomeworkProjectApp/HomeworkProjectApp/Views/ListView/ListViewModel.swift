//
//  ListViewModel.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI
import HomeworkDataModels
import SwiftData

class ListViewModel: ObservableObject {
    @Published var items: [ListedItem] = []
    @Published var hasNextPage: Bool = true
    @Published var isLoading: Bool = false
    @Published var hasEncounteredError: Bool = false
    @Published var hasNetworkConnection: Bool = false
    
    let listType: ListType
    
    private var offset: Int = 0
    private let limit: Int = 20
    
    init(listType: ListType) {
        self.listType = listType
    }
    
    @MainActor
    func fetchData(offset: Int = 0) async {
        guard !isLoading else { return }
        isLoading = true
        switch listType {
        case .pokemon:
            do {
                let listedResponse = try await DataFetcher.shared.fetchPokemonList(limit: limit,
                                                                                   offset: offset)
                hasNextPage = listedResponse.next != nil
                if offset == 0 {
                    items = listedResponse.results.toEntity()
                    isLoading = false
                } else {
                    items.append(contentsOf: listedResponse.results.toEntity())
                    isLoading = false
                }
            } catch {
                isLoading = false
                hasEncounteredError = true
            }
        default:
            break
        }
    }
    
    func getLocalItems(modelContext: ModelContext) {
        hasNextPage = false
        let localItems = try? modelContext.fetch(FetchDescriptor<Pokemon>())
        var listedItems: [ListedItem] = []
        for item in localItems ?? [] {
            listedItems.append(
                ListedItem(name: item.name,
                           id: item.id)
            )
        }
        items = listedItems
    }
    
    func fetchMoreData() async {
        guard !isLoading else { return }
        switch listType {
        case .pokemon:
            offset += limit
            await fetchData(offset: offset)
        default:
            break
        }
    }
}
