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
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach((0..<rows), id: \.self) { index in
                        NavigationLink(destination: OtherUserProfileView()) {
                            VStack {
                                Image("user_image_\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 180, height: 180)
                                    .cornerRadius(100)
                                HStack {
                                    Spacer()
                                    Text("●")
                                        .font(.system(size: 10))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.green)
                                    Text("24歳")
                                        .font(.system(size: 15))
                                    Text("滝野")
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
                }
            }
            .navigationTitle("1500")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
            }, label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.pink)
                Text("On")
                    .foregroundColor(.pink)
            }), trailing: HStack {
                Button(action: {
                    print("右のボタン１が押されました。")
                }, label: {
                    Image(systemName: "bell")
                })
            })
        }
    }
}

private struct PartnerUSerView: View {
    let imageNum: Int
    init(imageNum: Int) {
        self.imageNum = imageNum
    }
    var body: some View {
        VStack {
            Circle()
            Image("user_image_\(imageNum)")
                .resizable()
        }
        Text("こんちは")
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
