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
    
    var body: some View {
        VStack{
            Text("ok")
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                    selectedTab = 0
                } label : {
                    Label("idk", systemImage: "arrow.up")
                }
            }
        }
        
    }
}
