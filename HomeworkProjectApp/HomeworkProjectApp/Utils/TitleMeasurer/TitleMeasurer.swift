//
//  TitleMeasurer.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI

struct TitleMeasurer: View {
    let title: String

    var body: some View {
        Text(title)
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: TitleWidthKey.self, value: geo.size.width)
                }
            )
    }
}
