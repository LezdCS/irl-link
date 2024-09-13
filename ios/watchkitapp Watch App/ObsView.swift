//
//  ObsView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/12.
//

import Foundation
import SwiftUI


struct ObsView: View {
    @Binding var selectedTab: Int
    @ObservedObject var viewModel: WatchViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack{
            if(viewModel.obsConnected) {
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(viewModel.scenes, id: \.self) { scene in
                                Button(action: {
                                    viewModel.sendDataMessage(for: .sendChangeObsSceneToFlutter, data: ["scene": scene])
                                }) {
                                    Text(scene)
                                        .overlay {
                                            LinearGradient(
                                                colors: scene == viewModel.selectedScene ? [.purple, .blue] : [],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        }
                                        .mask(Text(scene))
                                }
                                .frame(width: 90)
                            }
                        }
                    }
                    Divider()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.sources, id: \.self) { item in
                                Text("Item \(item)")
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Text("OBS disconnected")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                    selectedTab = 0
                } label : {
                    Label("Back to top", systemImage: "arrow.up")
                }
            }
        }
    }
}
