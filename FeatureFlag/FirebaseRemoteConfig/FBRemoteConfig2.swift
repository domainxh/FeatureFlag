//
//  FBRemoteConfig2.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase

struct FeatureOneConfig: Codable {
    var studios: [Int]
    var isActive: Bool
}

struct AppPrimaryColorConfig: Codable {
    var color: String
}

enum RemoteConfigParameters: String, CaseIterable {
    case featureOne
    case featureTwo
    case appPrimaryColor
    
    var value: Codable? {
        switch self {
            case .featureOne:       return try? self.toCodable().get() as FeatureOneConfig
            case .featureTwo:       return try? self.toCodable().get() as FeatureOneConfig
            case .appPrimaryColor:  return try? self.toCodable().get() as AppPrimaryColorConfig
        }
    }

    private func toCodable<T: Codable>() -> Result<T, Error> {
        let data = RemoteConfig.remoteConfig().configValue(forKey: self.rawValue).dataValue
        return Result { try JSONDecoder().decode(T.self, from: data) }
    }
    
    var defaultValue: Data {
        switch self {
        case .featureOne:
            let config = FeatureOneConfig(studios: [1], isActive: false)
            return try! JSONEncoder().encode(config)
        case .featureTwo:
            let config = FeatureOneConfig(studios: [1], isActive: false)
            return try! JSONEncoder().encode(config)
        case .appPrimaryColor:
            let config = AppPrimaryColorConfig(color: "#0000FF") // Blue Color
            return try! JSONEncoder().encode(config)
        }
    }
}

