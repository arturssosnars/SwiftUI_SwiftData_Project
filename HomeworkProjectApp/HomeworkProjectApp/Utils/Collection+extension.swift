//
//  Collection+extension.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
