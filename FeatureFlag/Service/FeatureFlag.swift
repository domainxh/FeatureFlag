//
//  RemoteConfigFetcher.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase
import SwiftUI

enum ConfigState {
    case loading
    case loaded
    case error
}

class FeatureFlag {
    static let shared = FeatureFlag()
    private(set) var state: ConfigState?
    var finishCallback: (() -> Void)?
    
    var currentStudio = 1
    
    private init() {
        setConfigSetting()
        setDefaultValues()
    }
    

    private func setDefaultValues() {
        let appDefaults = FeatureFlagParameters.allCases.reduce([String: NSObject]()) { (dict, param) -> [String: NSObject] in
            var dict = dict
            dict[param.rawValue] = param.defaultValue as NSObject?
            return dict
        }

        RemoteConfig.remoteConfig().setDefaults(appDefaults)
    }
    
    private func setConfigSetting() {
        var minimumFetchInterval: Double // Unit of time in Second.

//        switch EnvironmentStyle.environment {
//        case .prod:
//            minimumFetchInterval = 3600
//        default:
            minimumFetchInterval = 0
//        }

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = minimumFetchInterval
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchData() {
        state = .loading
        
        RemoteConfig.remoteConfig().fetchAndActivate { [weak self] status, error in
            guard let self = self else { return }
            defer { self.finishCallback?() }
            
            guard error == nil, status == .successFetchedFromRemote else {
                self.state = .error
                return
            }
        
            self.state = .loaded
        }
    }
    
    func featureOneEnabled(mode: Mode) -> Bool {
        if mode == .dev {
            return UserDefaults.featureOneEnabled
        }
        
        guard let fbConfig = FeatureFlagParameters.featureOne.value as? StudioConfig,
              fbConfig.activeStudios.contains(currentStudio), fbConfig.isEnabled else { return false }
        return true
    }
    
    func featureTwoEnabled(mode: Mode) -> Bool {
        if mode == .dev {
            return UserDefaults.featureTwoEnabled
        }
        
        guard let fbConfig = FeatureFlagParameters.featureTwo.value as? StudioConfig,
              fbConfig.activeStudios.contains(currentStudio), fbConfig.isEnabled else { return false }
        return true
    }
    
    func getColor() -> Color {
        let colorConfig = FeatureFlagParameters.primaryColor.value as? ColorConfig
        return Color(hex: colorConfig!.color)
    }
}
