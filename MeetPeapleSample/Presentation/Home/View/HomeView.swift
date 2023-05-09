//
//  HomeView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct HomeEntity {
    let image: String
    let region: String
    let name: String
    let age: Int
    let onlineStatus: String
    let selfIntroduction: String
}

struct HomeView: View {
    let rows = 10
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 0,
                                                             alignment: .center),
                                            count: 2)
    private var storyColumns: [GridItem] = Array(repeating: .init(.flexible(),
                                                                  spacing: 0,
                                                                  alignment: .center),
                                                 count: 1)
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ScrollView (.horizontal) {
                        LazyHGrid(rows: storyColumns) {
                            ForEach((1...rows), id: \.self) { index in
                                NavigationLink(destination: PartnerImageView(imageName: "user_image_\(index)")) {
                                    StoryView(imageNum: index)
                                        .overlay(
                                            Circle()
                                                .stroke(.pink, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    }
                    .padding(10)
                    .scrollIndicators(.hidden)
                    LazyVGrid(columns: columns) {
                        ForEach((1...rows), id: \.self) { index in
                            NavigationLink(destination: OtherUserProfileView(imageNum: index)) {
                                PartnerUSerView(imageNum: index)
                            }
                            .navigationTitle("1500")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(leading: NavigationLink(destination: SearchView()) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.pink)
                                Text("On")
                                    .foregroundColor(.pink)
                            },
                                                trailing: NavigationLink(destination: NotificationView()) {
                                Image(systemName: "bell")
                            }
                            )}
                    }
                }
            }
        }
    }
}

private struct StoryView: View {
    let imageNum: Int
    
    init(imageNum: Int) {
        self.imageNum = imageNum
    }
    
    var body: some View {
        Image("user_image_\(imageNum)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .cornerRadius(50)
    }
}

private struct PartnerUSerView: View {
    let imageNum: Int
    init(imageNum: Int) {
        self.imageNum = imageNum
    }
    
    var body: some View {
        VStack {
            Image("user_image_\(imageNum)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 180)
                .cornerRadius(90)
            HStack {
                Spacer()
                Text("●")
                    .font(.system(size: 10))
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
                Text("24歳")
                    .font(.system(size: 15))
                Text("たっき〜")
                    .font(.system(size: 15))
                Spacer()
                Text("東京都")
                    .font(.system(size: 15))
                Spacer()
            }
            Spacer()
            Text("初めまして！仲良くなたら電話オッケーです！電話しましょう！")
                .lineLimit(2)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
