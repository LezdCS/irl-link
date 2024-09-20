//
//  SeView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/20.
//

import Foundation
import SwiftUI

struct SeView: View {
    @ObservedObject var viewModel: WatchViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack{
            if(!viewModel.seConnected) {
                Text("StreamElements not connected")
            }
            List(viewModel.seActivities, id: \.self) { activity in
                HStack {
                    Text(activity.message)
                    Text(activity.username)
                }
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
