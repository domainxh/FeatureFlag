//
//  FBRemoteConfig.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Firebase
import SwiftUI

enum ValueKey: String {
    case appPrimaryColor
}

class FBRemoteConfig {
  static let shared = FBRemoteConfig()

  private init() {
    loadDefaultValues()
    fetchCloudValues()
  }

  func loadDefaultValues() {
    let appDefaults: [String: Any?] = [ValueKey.appPrimaryColor.rawValue : "#FBB03B"] // Orange
    RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
  }
  
  func activateDebugMode() {
    let settings = RemoteConfigSettings()
    // WARNING: Don't actually do this in production!
    settings.minimumFetchInterval = 0
    RemoteConfig.remoteConfig().configSettings = settings
  }
  
  func fetchCloudValues() {
    activateDebugMode()
    RemoteConfig.remoteConfig().fetch { [weak self] _, error in
      if let error = error {
        print("Uh-oh. Got an error fetching remote values \(error)")
        return
      }
        
      RemoteConfig.remoteConfig().activate { _, _ in
        print("Retrieved values from the cloud!")
      }
    }
  }
  
  func color(forKey key: ValueKey) -> Color {
    let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFF"
    return Color(hex: colorAsHexString)
  }
}
