//
//  UserDefaults.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/15/21.
//

import Foundation

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            if
                let data = container.object(forKey: key) as? Data,
                let object = try? JSONDecoder().decode(Value.self, from: data) {
                return object
            }
            
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                container.set(encoded, forKey: key)
            }
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "featureOneEnabled", defaultValue: false)
    static var featureOneEnabled: Bool
    
    @UserDefault(key: "featureTwoEnabled", defaultValue: false)
    static var featureTwoEnabled: Bool
}
