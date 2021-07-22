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
        VStack {
            Text("Studio 1").font(.title)
            
            Picker("", selection: $viewModel.mode) {
                ForEach(Mode.allCases, id: \.self) {
                    Text("\($0)" as String)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            if viewModel.mode == .dev {
                Toggle("\(FeatureFlagParameters.featureOne.rawValue)", isOn: $viewModel.featureOneEnabled).onChange(of: viewModel.featureOneEnabled, perform: { _ in
                    viewModel.updateParam()
                })
                
                Toggle("\(FeatureFlagParameters.featureTwo.rawValue)", isOn: $viewModel.featureTwoEnabled).onChange(of: viewModel.featureTwoEnabled, perform: { _ in
                    viewModel.updateParam()
                })
            }

            Spacer().frame(height: 60)
            
            BaseLabel(text: FeatureFlagParameters.primaryColor.rawValue, color: viewModel.color)
//            Text(FeatureFlagParameters.primaryColor.rawValue)
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45)
//                .background(viewModel.color)
            
            if viewModel.featureOneEnabled {
                BaseLabel(text: FeatureFlagParameters.featureOne.rawValue, color: Color.yellow)
            }
            
            if viewModel.featureTwoEnabled {
                BaseLabel(text: FeatureFlagParameters.featureTwo.rawValue, color: Color.orange)
            }
            
            Spacer().frame(height: 60)
            
            Button(action: {
                viewModel.fetchData()
            }, label: {
                Text("Fetch Data")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 45)
                    .background(Color.black)
                    .foregroundColor(.white)
            })
        }
        .padding([.leading, .trailing], 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
