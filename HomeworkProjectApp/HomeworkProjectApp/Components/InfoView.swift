//
//  InfoView.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import SwiftUI

enum PairInfoType: Hashable {
    case nationalNumber(Int)
    case baseExperience(Int)
    case form([String])
    case height(String)
    case weight(String)
    case abilities([String])
    case stats([String: Int])
    case move([String])
    
    var title: String {
        switch self {
        case .nationalNumber:
            return "National No"
        case .baseExperience:
            return "Base Exp"
        case .form:
            return "Forms"
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        case .abilities:
            return "Abilities"
        case .stats:
            return "Base stats"
        case .move:
            return "Moves"
        }
    }
}

struct InfoView: View {
    let types: [PairInfoType]
    @State private var maxTitleWidth: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(types, id: \.self) { type in
                HStack(alignment: .top) {
                    Text(type.title)
                        .frame(width: maxTitleWidth, alignment: .leading)
                    VStack(alignment: .leading) {
                        switch type {
                        case .nationalNumber(let value):
                            Text("\(value)")
                        case .baseExperience(let value):
                            Text(String(value))
                        case .form(let values):
                            Text("\(values.joined(separator: "\n"))")
                        case .height(let value):
                            Text(value)
                        case .weight(let value):
                            Text(value)
                        case .abilities(let values):
                            Text((values.joined(separator: "\n")))
                        case .stats(let values):
                            Text(values.map { "\($0.key.capitalized): \($0.value)" }.joined(separator: "\n"))
                        case .move(let values):
                            Text((values.joined(separator: "\n")))
                        }
                    }
                }
                if let index = types.firstIndex(of: type), index != types.count - 1 {
                    Divider()
                }
            }
        }
        .overlay(
            VStack {
                ForEach(types, id: \.self) { type in
                    TitleMeasurer(title: type.title)
                }
            }
            .opacity(0)
        )
        .onPreferenceChange(TitleWidthKey.self) { width in
            maxTitleWidth = width
        }
    }
}

#Preview {
    InfoView(types: [.nationalNumber(1), .abilities(["Steadfast", "Inner Focus"])])
}
