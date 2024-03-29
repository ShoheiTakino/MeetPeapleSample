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

struct ProfileBackgroundView: View {
    var body: some View {
        // 線形グラデーション（青→黒）を生成
        LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .trailing)
    }
}


struct MyPageView: View {
    @State private var isProfileDetailVisible = false
    @State private var isVoiceWaiteing = UserDefaultsService.getIsLocalAuth()
    @State private var isVideoWaiteing = false
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 0,
                                                             alignment: .center),
                                            count: 3)
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                        Button {
                            withAnimation {
                                isProfileDetailVisible.toggle()
                            }
                        } label: {
                            ZStack {
                            ProfileBackgroundView()
                                .background(.pink.opacity(0.9))
                                .frame(width: 108, height: 108)
                                .cornerRadius(54)
                            Image("user_image_1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color.white, lineWidth: 3)
                                )
                            }
                        }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    VStack {
                        Text("タッキー")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        NavigationLink(destination: CalenderView()) {
                            Text("プロフィール確認")
                                .foregroundColor(.cyan)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text("10000")
                    Button {

                    } label: {
                        Text("ポイント追加")
                            .frame(width: 100, height: 50)
                    }
                }
                HStack {
                    Text("着信の許可設定")
                        .fontWeight(.light)
                        .font(.system(size: 15))
                    Text("(offにすると着信拒否になります)")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                }
                HStack {
                    Toggle("Face ID", isOn: $isVoiceWaiteing)
                        .onChange(of: isVoiceWaiteing) { newValue in
                            aaa(aaa: newValue)
                        }
                        .padding()
                    Toggle("ビデオ通話", isOn: $isVideoWaiteing)
                        .padding()
                }
                LazyHGrid(rows: columns) {
                    ForEach((1..<MyPageItems.allCases.count), id: \.self) { index in
                        VStack {
                            NavigationLink(destination: SettingView()) {
                                Image(systemName: MyPageItems.allCases[index].systemName)
                                    .frame(width: 100, height: 200)
                            }
                        }
                    }
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $isProfileDetailVisible, content: {
                ProfileIconImage(isVisible: $isProfileDetailVisible)
                    .transition(.move(edge: .top))
                    .backgroundClearSheet()
             })
        }
    }

    private func aaa(aaa: Bool) {
        Task {
            try await LocalauthManager().confirmInitAuth(aaa)
        }
    }
}

struct ProfileIconImage: View {

    @Binding var isVisible: Bool

    var body: some View {
        ZStack {
            ProfileEditBackgroundView().ignoresSafeArea()
            ProfileBackgroundView()
                .background(.pink.opacity(0.9))
                .frame(width: 108, height: 108)
                .cornerRadius(54)
            Image("user_image_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay {
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.clear, lineWidth: 10)
                }
            HStack {
                ZStack {
                    Image(systemName: "p.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)
                }
                .padding(EdgeInsets(top: 160, leading: 0, bottom: 0, trailing: 60))
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(EdgeInsets(top: 160, leading: 60, bottom: 0, trailing: 0))
            }
        }
        .onTapGesture {
            isVisible = false
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

struct ProfileEditBackgroundView: View {
    var body: some View {
        // 線形グラデーション（青→黒）を生成
        LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .green.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
    }
}

struct BackgroundClearView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        Task {
            view.superview?.superview?.backgroundColor = .white.withAlphaComponent(0.5)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension View {

    func backgroundClearSheet() -> some View {
        background(BackgroundClearView())
    }
}
