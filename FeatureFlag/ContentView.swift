//
//  ContentView.swift
//  FeatureFlag
//
//  Created by Xiaoheng Pan on 7/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Text("appPrimaryColor")
            .padding()
            .background(viewModel.color)
        if viewModel.isFeatureOneActive {
            Text("FeatureOneIsActive")
                .padding()
                .background(Color.yellow)
        }
        
        if viewModel.isFeatureTwoActive {
            Text("FeatureTwoIsActive")
                .padding()
                .background(Color.purple)
        }
        Button(action: {
            viewModel.fetchRemoteData()
        }, label: {
            Text("Click to Fetch Remote Data")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45)
                .background(Color.gray)
                .foregroundColor(.white)
                .padding()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ContentView(viewModel: viewModel)
    }
}
