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
            VStack {
                HStack {
                    Text("\(viewModel.viewers) viewers")
                    Spacer()
                    Text(viewModel.isLive ? "Online" : "Offline")
                }.padding()
                List(viewModel.messages, id: \.self) { message in
                    HStack(alignment: .top) {
                        HStack {
                            ForEach(message.badges, id: \.self) { badge in
                                AsyncImage(url: URL(string: badge)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 12, height: 12)
                            }
                            Text(message.username)
                                .foregroundColor(Color(hex: message.color))
                                .font(.system(size: 14, weight: .bold, design: .default))
                                .frame(alignment: .leading)
                        }
                        Text(message.message)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14, design: .default))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    //                .listRowPlatterColor(Color.green)
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .tag(0)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        selectedTab = 1
                    } label : {
                        Label("SE", systemImage: "minus")
                    }
                    Button {
                    } label : {
                        Label("OBS", systemImage: "plus")
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea(edges: .top)
//            .containerBackground(Color.purple.gradient, for: .tabView)
            VStack{
                Text("ok")
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
//                       TODO: go to OBS tab
                    } label : {
                        Label("idk", systemImage: "plus")
                    }
                }
            }
            .tag(1)
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    let viewModel: WatchViewModel = WatchViewModel()
    viewModel.messages.append(Message(username: "Lezd_", message: "No wayyyyyy", color: "#eb4634", badges: [
        "https://static-cdn.jtvnw.net/badges/v1/b817aba4-fad8-49e2-b88a-7cc744dfa6ec/3"
    ]))
    viewModel.messages.append(Message(username: "Julien", message: "This is a longer message haha I am very long!", color: "#73fc03", badges: []))
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
}
