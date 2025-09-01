//
//  ListView.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftData
import SwiftUI
import HomeworkDataModels

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: ListViewModel
    @Binding var path: NavigationPath
    
    init(listType: ListType, navigationPath: Binding<NavigationPath>) {
        self.viewModel = ListViewModel(listType: listType)
        self._path = navigationPath
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    if let item = viewModel.items[safe: index] {
                        Button {
                            if let id = item.id {
                                path.append(Destination.pokemon(id: id))
                            }
                        } label: {
                            HStack {
                                Text(item.name.capitalized)
                                    .font(.subheadline)
                                    .foregroundStyle(.green)
                            }
                            .onAppear {
                                if viewModel.hasNextPage, index == viewModel.items.count - 1 {
                                    Task {
                                        await viewModel.fetchMoreData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .overlay {
                if !viewModel.hasNetworkConnection && viewModel.items.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No data", systemImage: "nosign")
                    }, description: {
                        Text("No local data in pokedex. Please check your internet connection.")
                    })
                }
            }
        }
        .task {
            guard viewModel.items.isEmpty else { return }
            viewModel.hasNetworkConnection = await NetworkMonitor.shared.isConnected()
            if viewModel.hasNetworkConnection {
                await viewModel.fetchData()
            } else {
                viewModel.getLocalItems(modelContext: modelContext)
            }
        }
    }
}
