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
                VStack {
                    HStack {
                        Circle()
                            .fill(Color(argb: activity.colors[0]))
                            .frame(width: 10, height: 10)
                        Text(activity.text)
                            .font(.system(size: 14, design: .default))
                        Text(activity.username)
                            .font(.system(size: 14, design: .default))
                            .foregroundColor(Color(argb: activity.colors[0]))
                        
                    }
                    if(activity.message != "") {
                        Text(activity.message)
                            .font(.system(size: 14, design: .default))
                    }
                }
                .listRowPlatterColor(Color(argb: activity.colors[1]))
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
