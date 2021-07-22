//
//  ButtonView.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/22/21.
//

import SwiftUI

struct BaseLabel: View {
    var text = ""
    var color = Color.green
    
    var body: some View {
        Text("\(text) is enabled")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45)
            .background(color)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BaseLabel()
    }
}
