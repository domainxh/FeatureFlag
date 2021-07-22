//
//  FeatureFlagParameters.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase

struct StudioConfig: Codable {
    var activeStudios: [Int]
    var isEnabled: Bool
}

struct ColorConfig: Codable {
    var color: String
}

enum FeatureFlagParameters: String, CaseIterable {
    case featureOne
    case featureTwo
    case primaryColor
    
    var value: Codable? {
        switch self {
            case .featureOne:
                return try? self.toCodable().get() as StudioConfig
            case .featureTwo:
                return try? self.toCodable().get() as StudioConfig
            case .primaryColor:
                return try? self.toCodable().get() as ColorConfig
        }
    }
    
    var defaultValue: Data {
        switch self {
        case .featureOne:
            let config = StudioConfig(activeStudios: [1, 2, 3], isEnabled: false)
            return try! JSONEncoder().encode(config)
        case .featureTwo:
            let config = StudioConfig(activeStudios: [1, 2, 3], isEnabled: false)
            return try! JSONEncoder().encode(config)
        case .primaryColor:
            let config = ColorConfig(color: "#0000FF")
            return try! JSONEncoder().encode(config)
        }
    }
    
    private func toCodable<T: Codable>() -> Result<T, Error> {
        let data = RemoteConfig.remoteConfig().configValue(forKey: self.rawValue).dataValue
        return Result { try JSONDecoder().decode(T.self, from: data) }
    }
}

