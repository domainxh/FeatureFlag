//
//  ViewModel.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase
import SwiftUI

class ViewModel: ObservableObject {

    @Published var color = Color.green
    @Published var isFeatureOneActive = false
    @Published var isFeatureTwoActive = false
    private var currentStudio = 1

    init() {
        updateViews()
    }
    
    func fetchRemoteData() {
        FBRemoteConfig2.fetch()
        updateViews()
    }
    
    private func updateViews() {
        if let fbConfig = RemoteConfigParameters.appPrimaryColor.value as? AppPrimaryColorConfig {
            color = Color(hex: fbConfig.color)
        }

        if let fbConfig = RemoteConfigParameters.featureOne.value as? FeatureOneConfig {
            if fbConfig.studios.contains(currentStudio) {
                isFeatureOneActive = fbConfig.isActive
            } else {
                isFeatureOneActive = false
            }
        }
        
        if let fbConfig = RemoteConfigParameters.featureTwo.value as? FeatureOneConfig {
            if fbConfig.studios.contains(currentStudio) {
                isFeatureTwoActive = fbConfig.isActive
            } else {
                isFeatureTwoActive = false
            }
        }
    }
}
