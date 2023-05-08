//
//  MainTabView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("さがす")
                }
            MessageTabView()
                .tabItem {
                    Image(systemName: "message")
                    Text("メッセージ")
                }
            InstantCallView()
                .tabItem {
                    Image(systemName: "video")
                    Text("今すぐ通話")
                }
            BoardView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("掲示板")
                }
            MyPageView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("マイページ")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .accentColor(.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
