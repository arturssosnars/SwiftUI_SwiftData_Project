//
//  LoadingPlaceholderView.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI

struct LoadingPlaceholderView: View {
    let cornerRadius: CGFloat
    let bandSize: CGFloat
    let initial: Bool
    
    
    init(cornerRadius: CGFloat = 8, bandSize: CGFloat = 2, initial: Bool = false) {
        self.cornerRadius = cornerRadius
        self.bandSize = bandSize
        self.initial = initial
    }

    var body: some View {
        Rectangle()
            .fill(.black)
            .overlay(
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width)
                    .shimmering(bandSize: bandSize)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct Shimmer: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    private let min, max: CGFloat
    @State private var isInitialState = true
    
    public init(
        bandSize: CGFloat = 0.3
    ) {
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }
    
    var startPoint: UnitPoint {
        isInitialState ? UnitPoint(x: min, y: 0.5) : UnitPoint(x: 1, y: 0.5)
    }
    
    var endPoint: UnitPoint {
        isInitialState ? UnitPoint(x: 0, y: 0.5) : UnitPoint(x: max, y: 0.5)
    }

    public func body(content: Content) -> some View {
        applyingGradient(to: content)
            .animation(
                reduceMotion ? nil : .linear(duration: 1.5).delay(0.3).repeatForever(autoreverses: false),
                value: isInitialState
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    isInitialState = false
                }
            }
    }

    @ViewBuilder public func applyingGradient(to content: Content) -> some View {
        let gradient = LinearGradient(colors: [.clear, .black, .clear], startPoint: startPoint, endPoint: endPoint)
        content.mask(gradient)
    }
}

extension View {
    @ViewBuilder func shimmering(
        active: Bool = true,
        bandSize: CGFloat = 0.5
    ) -> some View {
        if active {
            modifier(Shimmer(bandSize: bandSize))
        } else {
            self
        }
    }
}

