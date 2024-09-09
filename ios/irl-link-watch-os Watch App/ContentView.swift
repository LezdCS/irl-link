//
//  ContentView.swift
//  irl-link-watch-os Watch App
//
//  Created by Julien on 2024/09/07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
    
    var body: some View {
        VStack {
            Text("Counter: \(viewModel.counter)")
                .padding()
            Button(action: {
                viewModel.sendDataMessage(for: .sendCounterToFlutter, data: ["counter": viewModel.counter + 1])
            }) {
                Text("+ by 2")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
