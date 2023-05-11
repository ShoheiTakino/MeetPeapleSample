//
//  MyPageView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

enum MyPageItems: CaseIterable {
    case footprint
    case setting
    case favolite
    case good
    case dailyBounace
    case gallary
    case callHistory
    case ranking
    
    var title: String {
        switch self {
        case .footprint: return "足あと"
        case .setting: return "設定・ヘルプ"
        case .favolite: return "お気に入り"
        case .good: return "いいね"
        case .dailyBounace: return "デイリーボーナス"
        case .gallary: return "ギャラリー"
        case .callHistory: return "通話履歴"
        case .ranking: return "ランキング"
        }
    }
    
    var systemName: String {
        switch self {
        case .footprint: return "foot"
        case .setting: return "gearshape"
        case .favolite: return "star"
        case .good: return "hand.thumbsup"
        case .dailyBounace: return "p.circle.fill"
        case .gallary: return "photo.on.rectangle.angled"
        case .callHistory: return "phone"
        case .ranking: return "photo"
        }
    }
    
//    var myPageItemsView: View {
//        switch self {
//        case .footprint: return FootprintView()
//        case .setting: return SettingView()
//        case .favolite: return FavoliteView()
//        case .good: return GoodView()
//        case .dailyBounace: return DailyBounaceView()
//        case .gallary: return GallaryView()
//        case .callHistory: return CallHistoryView()
//        case .ranking: return RankingView()
//        }
//    }
}

struct MyPageView: View {
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 0,
                                                             alignment: .center),
                                            count: 3)
    var body: some View {
        VStack {
            HStack {
                Image("user_image_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                VStack {
                    Text("タッキー")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    Text("プロフィール確認")
                        .foregroundColor(.cyan)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            HStack {
                Text("10000")
                Button {
                    
                } label: {
                    Text("ポイント追加")
                }
            }
            HStack {
                Text("着信の許可設定")
                    .fontWeight(.light)
                    .font(.system(size: 18))
                Text("(offにすると着信拒否になります)")
                    .fontWeight(.light)
                    .font(.system(size: 13))
            }
            HStack {
                Text("音声通話")
                Text("音声通話")
                Text("ビデオ通話")
                Text("ビデオ通話")
            }
            LazyHGrid(rows: columns) {
                ForEach((1..<MyPageItems.allCases.count), id: \.self) { index in
                    NavigationLink(destination: SettingView()) {
                        VStack {
                            Image(systemName: MyPageItems.allCases[index].systemName)
                                .frame(width: 100, height: 100)
//                            Text(MyPageItems.allCases[index].title)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
