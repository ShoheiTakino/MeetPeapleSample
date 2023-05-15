//
//  InstantCallView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

enum ParterStatus: CaseIterable {
    case call
    case contents
    case time
    
    var title: String {
        switch self {
        case .call: return "通話OK"
        case .contents: return "なんでも"
        case .time: return "いつでも"
        }
    }
}

struct InstantCallView: View {
    private var screenWidth = UIScreen.main.bounds.width
    private var storyColumns: [GridItem] = Array(repeating: .init(.flexible(),
                                                                  spacing: 0,
                                                                  alignment: .center),
                                                 count: 1)
    private let rows = 10
    @State private var selectedNum = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Button {
                            if selectedNum == 1 { return }
                            selectedNum -= 1
                        } label: {
                            Image(systemName: "lessthan.circle.fill")
                        }
                        .frame(width: 50, height: 50)
                        Image("user_image_\(selectedNum)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screenWidth / 1.8, height:  screenWidth / 1.8)
                            .cornerRadius(25)
                            .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 5))
                        // TODO: overlayで何分前つける
                        Button {
                            if selectedNum == 10 { return }
                            selectedNum += 1
                        } label: {
                            Image(systemName: "greaterthan.circle.fill")
                        }
                        .frame(width: 50, height: 50)
                    }
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: storyColumns) {
                                ForEach((1...rows), id: \.self) { index in
                                    Button {
                                        selectedNum = index
                                    } label: {
                                        OtherImageView(imageNum: index)
                                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 100, trailing: 10))
                    }
//                    Spacer()
                }
                .frame(width: screenWidth, height: screenWidth, alignment: .top)
                .background(.gray)
                VStack {
                    HStack {
                        Text("しょうへい")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 20))
                        Text("24歳")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("東京都")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    }
                    Text("初めまして！仲良くなたら電話オッケーです！電話しましょう！")
                        .lineLimit(1)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 7, leading: 5, bottom: 0, trailing: 7))
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: storyColumns) {
                            ForEach((0..<ParterStatus.allCases.count), id: \.self) { index in
                                Text(ParterStatus.allCases[index].title)
                                    .font(.system(size: 10))
                                    .foregroundColor(.cyan)
                                    .frame(width: 50, height: 25)
                                    .cornerRadius(20)
                                    .minimumScaleFactor(1.0)
                                    .background(.white)
                                    .border(.cyan, width: 1)
                                    .cornerRadius(20)
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                    Button {
                        
                    } label: {
                        Text("通話を発信する")
                            .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 7))
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width: 260, height: 50)
                            .background(.cyan)
                            .cornerRadius(20)
                    }
                }
                Spacer()
            }
            .navigationTitle("💰1500")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
        }
        .onAppear() {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

private struct OtherImageView: View {
    let imageNum: Int
    
    init(imageNum: Int) {
        self.imageNum = imageNum
    }
    
    var body: some View {
        Image("user_image_\(imageNum)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .cornerRadius(10)
    }
}

struct InstantCallView_Previews: PreviewProvider {
    static var previews: some View {
        InstantCallView()
    }
}
