//
//  ObsView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/12.
//

import Foundation
import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: WatchViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(viewModel.isLive ? Color.red : Color.gray)
                    .frame(width: 10, height: 10)
                Text(viewModel.isLive ? "Live" : "Offline")
                Spacer()
            }.padding()
            ScrollViewReader { proxy in
                List(viewModel.messages, id: \.self) { message in
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(message.badges, id: \.self) { badge in
                            AsyncImage(url: URL(string: badge)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 12, height: 12)
                            .padding(.trailing, 4)
                            .padding(.top, 2)
                        }
                        Text(message.username)
                            .foregroundColor(Color(hex: message.color))
                            .font(.system(size: 14, weight: .bold, design: .default))
                        Text(":")
                            .font(.system(size: 14, design: .default))
                            .padding(.trailing, 4)
                        Text(message.message)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14, design: .default))
                    }
                    .listRowInsets(.init(top: -2, leading: 0, bottom: -2, trailing: 0))
                    .listRowBackground(Color.clear)
//                    .listRowPlatterColor(Color.green)
                }
                .onChange(of: viewModel.messages) {
                    proxy.scrollTo(viewModel.messages.last, anchor: .top)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    Text("\(viewModel.viewers)")
                    Image(systemName: "person")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                }
                HStack {
                    Button("OBS") {
                        selectedTab = 1
                    }
                    .frame(width: 50)
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .ignoresSafeArea(edges: .top)
    }
}
