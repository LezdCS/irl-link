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
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("\(viewModel.viewers)")
                    Image(systemName: "person")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                }
                Text(viewModel.isLive ? "Live" : "Not live")
                Spacer()
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
        
    }
}
