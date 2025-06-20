//
//  ContentView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WatchViewModel = WatchViewModel()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ChatView(viewModel: viewModel, selectedTab: $selectedTab)
                .tag(0)
            ObsView(selectedTab: $selectedTab, viewModel: viewModel)
                .tag(1)
            SeView(viewModel: viewModel, selectedTab: $selectedTab)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    let viewModel: WatchViewModel = WatchViewModel()
    viewModel.messages = [
        Message(id: "1", username: "Julien", message: "Ok", color: "#73fc03", badges: []),
        Message(id: "2",username: "Julien", message: "Tesst long message omg looooooong", color: "#73fc03", badges: []),
        Message(id:" 3", username: "Lezd_", message: "No wayyyyy", color: "#eb4634", badges: [
            "https://static-cdn.jtvnw.net/badges/v1/b817aba4-fad8-49e2-b88a-7cc744dfa6ec/3"
        ]),
    ]
    viewModel.viewers = 123
    viewModel.isLive = true
    viewModel.obsConnected = true
    viewModel.scenes = ["test1", "test2"]
    viewModel.selectedScene = "test2"
    viewModel.sources = [
        ObsSource(sceneItemId: 1, sceneItemEnabled: true, sourceName: "Source 1"),
        ObsSource(sceneItemId: 2, sceneItemEnabled: false, sourceName: "Source 2"),
    ]
    viewModel.seConnected = true
    viewModel.seActivities = [
        SeActivity(id: "1", message: "", text: "Follow", username: "Lezd_", colors: [
            4279998688, 4279445821
        ])
    ]
    return ContentView(viewModel: viewModel)
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    init(argb: Int64) {
        let a = Double((argb >> 24) & 0xFF) / 255.0
        let r = Double((argb >> 16) & 0xFF) / 255.0
        let g = Double((argb >> 8) & 0xFF) / 255.0
        let b = Double(argb & 0xFF) / 255.0
        
        self = Color(red: r, green: g, blue: b, opacity: a)
    }
}
