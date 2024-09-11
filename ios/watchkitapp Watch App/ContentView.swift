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
        TabView {
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
            .environment(\.defaultMinListRowHeight, 10)
//            .containerBackground(Color.purple.gradient, for: .tabView)
            VStack{
                Text("ok")
            }.toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
//                       TODO: open menu?
                    } label : {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    ContentView()
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
