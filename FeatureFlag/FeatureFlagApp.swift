//
//  FeatureFlagApp.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import SwiftUI
import Firebase

@main
struct FeatureFlagApp: App {
    
    init() {
        FirebaseApp.configure()
        FBRemoteConfig2.fetch()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
