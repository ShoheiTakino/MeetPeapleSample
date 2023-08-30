//
//  BoardView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct BoardView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1..<11) { index in
                    HStack {
//                        NavigationLink(destination: OtherUserProfileView(meetPeopleEntity: index)) {
//                            Image("user_image_\(index)")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 70, height: 70)
//                                .cornerRadius(35)
//                        }
                        VStack {
                            Text("たっき〜")
                                .frame(alignment: .leading)
                            Text("音声通話しましょう！")
                                .frame(alignment: .leading)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("掲示板(すべて)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
                    .tint(.gray)
            })
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
