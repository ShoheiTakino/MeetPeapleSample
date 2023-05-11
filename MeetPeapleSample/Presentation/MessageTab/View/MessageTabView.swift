//
//  MessageTabView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct MessageTabView: View {
    enum MessageTab: String, CaseIterable, Identifiable {
        case all = "すべて"
        case alerdySent = "やりとり中"
        case favorite = "お気に入り"
        var id: String { rawValue }
    }
    
    @State private var selectedFriend = MessageTab.all
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("友達", selection: $selectedFriend) {
                    ForEach(MessageTab.allCases) {
                        tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                Spacer()
                List {
                    ForEach(1..<11) { index in
                        HStack {
                            NavigationLink(destination: DirectMessageView()) {
                                EmptyView()
                                Image("user_image_\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                VStack {
                                    Text("たっき〜")
                                        .frame(alignment: .leading)
                                        .font(.body)
                                        .foregroundColor(.black)
                                    Text("音声通話しましょう！")
                                        .frame(alignment: .leading)
                                        .font(.body)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            .foregroundColor(.cyan)
            .pickerStyle(.segmented)
            .padding()
            .listStyle(.plain)
            .navigationTitle("メッセージ")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: NotificationView()) {
                Text("編集")
                    .tint(.black)
            })
        }
    }
}

struct MessageTabView_Previews: PreviewProvider {
    static var previews: some View {
        MessageTabView()
    }
}
