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
            RevenueChartView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("さがす")
                }
            MessageTabView()
                .tabItem {
                    Image(systemName: "message")
                    Text("メッセージ")
                }
            RecordingListView()
                .tabItem {
                    Image(systemName: "play")
                    Text("録音する")
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

struct Tab: View {
    @State var index = 0
    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                if index == 0 {
                    Color.black.opacity(0.05)
                } else if index == 1 {
                    Color.orange
                } else if index == 2 {
                    Color.red
                } else if index == 3 {
                    Color.blue
                }
            }

            CircleTab(index: $index)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CircleTab: View {

    @Binding var index: Int
    var body: some View {
        HStack {
            Button {
                index = 0
            } label: {
                VStack {
                    if index != 0 {
                        Image(systemName: "magnifyingglass").foregroundColor(.black.opacity(0.2))
                    } else {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        Text("Search")
                            .foregroundColor(.black.opacity(0.7))
                    }
                }

            }

            Spacer(minLength: 15)

            Button {
                index = 1
            } label: {
                VStack {
                    if index != 1 {
                        Image(systemName: "bubble.right").foregroundColor(.black.opacity(0.2))
                    } else {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        Text("Meesage")
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
            }

            Spacer(minLength: 15)

            Button {
                index = 2
            } label: {
                VStack {
                    if index != 2 {
                        Image(systemName: "doc.plaintext").foregroundColor(.black.opacity(0.2))
                    } else {
                        Image(systemName: "doc.plaintext")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        Text("Board")
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
            }

            Spacer(minLength: 15)

            Button {
                index = 3
            } label: {
                VStack {
                    if index != 3 {
                        Image(systemName: "house").foregroundColor(.black.opacity(0.2))
                    } else {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        Text("MyPage")
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
            }
        }.padding(.vertical, -10)
            .padding(.horizontal, 25)
            .background(.white)
            .animation(.spring())
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
