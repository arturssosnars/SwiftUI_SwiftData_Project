//
//  TitleWidthKey.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI

struct TitleWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
