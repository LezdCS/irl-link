//
//  ObsView.swift
//  watchkitapp Watch App
//
//  Created by Julien on 2024/09/12.
//

import Foundation
import SwiftUI
import CachedAsyncImage

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
                            CachedAsyncImage(url: URL(string: badge)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 12, height: 12)
                            .padding(.trailing, 4)
                            .padding(.top, 6)
                        }
                        Text(attributedMessage(message: message))
                    }
                    .id(message)
                    .listRowInsets(.init(top: -2, leading: 0, bottom: -2, trailing: 0))
                    .listRowBackground(Color.clear)
                    //                    .listRowPlatterColor(Color.green)
                }
                .onChange(of: viewModel.messages) { _ in
                    proxy.scrollTo(viewModel.messages.last, anchor: .bottom)
                }
            }
        }
        .overlay(
            VStack {
                Spacer()
                HStack {
                    HStack {
                        Text("\(viewModel.viewers)")
                        Image(systemName: "person")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        Button("OBS") {
                            selectedTab = 1
                        }
                        .font(.system(size: 12))
                        .frame(width: 40, height: 25)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("SE") {
                            selectedTab = 2
                        }
                        .font(.system(size: 12))
                        .frame(width: 40, height: 25)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
                .background(Color.black.opacity(0.8))
            }
        )
        .environment(\.defaultMinListRowHeight, 10)
        .ignoresSafeArea(edges: .top)
    }
}

// Function to build the AttributedString with different styles
func attributedMessage(message: Message) -> AttributedString {
    var attributedString = AttributedString("\(message.username): \(message.message)")
    
    // Apply a style to the username part
    if let usernameRange = attributedString.range(of: message.username) {
        attributedString[usernameRange].foregroundColor = Color(hex: message.color)
        attributedString[usernameRange].font = .system(size: 14)
    }
    
    // Apply a style to the message part
    if let messageRange = attributedString.range(of: message.message) {
        attributedString[messageRange].foregroundColor = .white
        attributedString[messageRange].font = .system(size: 14)
    }
    
    return attributedString
}
