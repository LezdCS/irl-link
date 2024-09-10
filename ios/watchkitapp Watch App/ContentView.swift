//
//  ContentView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.messages, id: \.self) { message in
                Text(message)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
