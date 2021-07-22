//
//  ViewModel.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import Foundation
import Firebase
import SwiftUI

enum Mode: String, CaseIterable, Codable {
    case dev
    case prod
}

class ViewModel: ObservableObject {

    @Published var color = Color.red
    @Published var mode = Mode.prod {
        didSet {
            updateParam()
        }
    }
    
    @Published var featureOneEnabled = false {
        didSet {
            guard mode == .dev else { return }
            UserDefaults.featureOneEnabled = featureOneEnabled
        }
    }
    
    @Published var featureTwoEnabled = false {
        didSet {
            guard mode == .dev else { return }
            UserDefaults.featureTwoEnabled = featureTwoEnabled
        }
    }
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        FeatureFlag.shared.fetchData()
        FeatureFlag.shared.finishCallback = updateParam
    }
    
    func updateParam() {
        color = FeatureFlag.shared.getColor()
        featureOneEnabled = FeatureFlag.shared.featureOneEnabled(mode: mode)
        featureTwoEnabled = FeatureFlag.shared.featureTwoEnabled(mode: mode)
    }
}
