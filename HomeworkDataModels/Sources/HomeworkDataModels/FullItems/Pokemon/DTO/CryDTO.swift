//
//  Cry.swift
//  HomeworkDataModels
//
//  Created by Arturs Sosnars on 31/08/2025.
//

import Foundation

public struct CryDTO: Decodable, Sendable {
    public let latest: String
    
    enum CodingKeys: String, CodingKey {
        case latest
    }
}

extension CryDTO {
    func toEntity() -> Cry {
        return Cry(latest: latest)
    }
}
