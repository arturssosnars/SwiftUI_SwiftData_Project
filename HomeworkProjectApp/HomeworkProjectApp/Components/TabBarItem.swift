//
//  TabBarItem.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI
import HomeworkDataModels

struct TabBarItem: View {
    @State var path = NavigationPath()
    @Binding var selectedType: ListType
    let type: ListType
    
    var body: some View {
        NavigationStack(path: $path) {
            ListView(listType: type, navigationPath: $path)
                .navigationDestination(for: Destination.self) { destination in
                    Destination.view(for: destination)
                }
        }
        .tabItem {
            Image(selectedType == type ? type.imageNameSelected : type.imageName)
            Text(type.title)
        }
        .tag(type)
    }
}

#Preview {
    let selectedType: Binding<ListType> = .constant(.pokemon)
    TabView {
        TabBarItem(selectedType: selectedType, type: .pokemon)
        TabBarItem(selectedType: selectedType, type: .test)
    }
}
