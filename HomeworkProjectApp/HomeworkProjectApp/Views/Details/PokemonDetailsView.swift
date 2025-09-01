//
//  PokemonDetailsView.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI
import SwiftData
import HomeworkDataModels

struct PokemonDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: PokemonDetailsViewModel = PokemonDetailsViewModel()
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        VStack {
            if let pokemon = viewModel.pokemon {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        let width = (UIScreen.main.bounds.width - 48) / 2
                        HStack(spacing: 16) {
                            insertImage(data: pokemon.sprites.images?.frontDefault, width: width)
                            insertImage(data: pokemon.sprites.images?.frontShiny, width: width)
                        }
                        HStack(spacing: 16) {
                            insertImage(data: pokemon.sprites.images?.frontDefaultFemale, width: width)
                            insertImage(data: pokemon.sprites.images?.frontShinyFemale, width: width)
                        }
                        InfoView(types: [
                            .nationalNumber(pokemon.id),
                            .baseExperience(pokemon.baseExperience),
                            .form(pokemon.forms.toList()),
                            .height(pokemon.height.heightString),
                            .weight(pokemon.weight.weightString),
                            .abilities(pokemon.abilities.toList()),
                            .stats(pokemon.stats.toList()),
                            .move(pokemon.moves.toList())
                        ])
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationTitle(Text((viewModel.pokemon?.name ?? "Loading").capitalized))
        .task {
            if await NetworkMonitor.shared.isConnected() {
                await viewModel.fetchData(for: id, using: modelContext)
            } else {
                viewModel.pokemon = viewModel.fetchLocalData(for: id, using: modelContext)
            }
        }
        .alert("Something unexpected happened", isPresented: $viewModel.hasEncounteredError) {
            Button("OK", role: .cancel) {
                viewModel.hasEncounteredError = false
                dismiss()
            }
        }
    }
    
    @ViewBuilder
    func insertImage(data: Data?, width: CGFloat) -> some View {
        if let data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: width)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    PokemonDetailsView(id: 1)
}
