//
//  RemoteConfigFetcher.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase

enum FBRemoteConfigState {
    case loading
    case loaded
    case error
}

enum FBRemoteConfig2 {

    static private(set) var state: FBRemoteConfigState? = nil
    static var finishCallback: (() -> Void)? = nil

    static func fetch() {
        setDefaultValues()
        fetchRemoteValues()
    }
    
    private static func setDefaultValues() {
        let appDefaults = RemoteConfigParameters.allCases.reduce([String: NSObject]()) { (dict, param) -> [String: NSObject] in
            var dict = dict
            dict[param.rawValue] = param.defaultValue as NSObject
            return dict
        }

        RemoteConfig.remoteConfig().setDefaults(appDefaults)
    }

    private static func activateDebugMode() {
      let settings = RemoteConfigSettings()
      // WARNING: Don't actually do this in production!
      settings.minimumFetchInterval = 0
      RemoteConfig.remoteConfig().configSettings = settings
    }
    
    private static func fetchRemoteValues() {
        activateDebugMode()
        state = .loading
        #warning("Only set expirationDuration to 0 in debug mode.")

        RemoteConfig.remoteConfig().fetch { (status, error) in
            defer {
                finishCallback?()
            }
            
            guard error == nil, status == .success else {
                state = .error
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
              print("Retrieved values from the cloud!")
            }
            state = .loaded
        }
        

    }
}
