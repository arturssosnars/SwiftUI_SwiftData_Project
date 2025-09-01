//
//  ContentView.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import SwiftUI
import SwiftData
import HomeworkDataModels

struct ContentView: View {
    @State var selectedType: ListType = .pokemon
    let tabBarTypes: [ListType] = [.pokemon]

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedType) {
                ForEach(tabBarTypes) { type in
                    TabBarItem(selectedType: $selectedType, type: type)
                }
            }
            .navigationTitle(selectedType.title)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
