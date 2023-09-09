//
//  HomeView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI
import Shimmer

struct MeetPeopleEntity {
    let image: String
    let region: String
    let name: String
    let age: Int
    let isVoiceCallStatas: Bool
    let selfIntroduction: String
}

struct HomeView: View {
    private let rows = 10
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 0,
                                                             alignment: .center),
                                            count: 2)
    private var storyColumns: [GridItem] = Array(repeating: .init(.flexible(),
                                                                  spacing: 0,
                                                                  alignment: .center),
                                                 count: 1)
    let screenWidth = UIScreen.main.bounds.width
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
//                    Image(systemName: "person")
//                        .background(Color.black)
//                        .frame(width: .infinity, height: 50)
                    ScrollView (.horizontal) {
                        LazyHGrid(rows: storyColumns) {
                            ForEach((0..<viewModel.meetPeopleEntityList.count), id: \.self) { index in
                                NavigationLink(destination: PartnerImageView(imageName: "user_image_\(viewModel.meetPeopleEntityList[index].image)")) {
                                    StoryView(meetPeopleEntity: viewModel.meetPeopleEntityList[index])
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
                        ForEach(0..<viewModel.meetPeopleEntityList.count, id: \.self) { index in
                            NavigationLink(destination: OtherUserProfileView(meetPeopleEntity: viewModel.meetPeopleEntityList[index])) {
                                PartnerUSerView(meetPeopleEntity: viewModel.meetPeopleEntityList[index], isLoading: $viewModel.isLoading)
                            }
                            .navigationTitle(Text("💰 1000"))
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(leading: NavigationLink(destination: SearchView()) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.pink)
                                Text("On")
                                    .foregroundColor(.pink)
                            },trailing: NavigationLink(destination: NotificationView()) {
                                Image(systemName: "bell")
                            }
                            )}
                    }
                }
            }
            .refreshable {
                viewModel.pulledToRefresh()
            }
        }
    }
}

//struct ReportAndBl0ckAlertView<Content>: View where Content: View {
//    let action: () -> Void
//    var body: some View {
//        return Alert(title: Text(""), message: Text("dd"), dismissButton: .default(Text("fff")))
//    }
//}

private struct StoryView: View {
    let meetPeopleEntity: MeetPeopleEntity
    
    init(meetPeopleEntity: MeetPeopleEntity) {
        self.meetPeopleEntity = meetPeopleEntity
    }
    
    var body: some View {
        Image("user_image_\(meetPeopleEntity.image)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .cornerRadius(50)
    }
}

private struct PartnerUSerView: View {

    let meetPeopleEntity: MeetPeopleEntity
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Image("user_image_\(meetPeopleEntity.image)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 180)
                .cornerRadius(90)
                .overlay(
                    HStack {
                        Image(systemName: "phone.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .position(x: 20, y:20)
                            .tint(.green)
//                        Text("New")
//                            .frame(width: 50, height: 30, alignment: .center)
//                            .position(x: 70, y:20)
//                            .tint(.red)
                    }
                )
//                .redacted(reason: isLoading ? [] : .placeholder)
//                .shimmering(active: !isLoading, animation: .easeInOut)
            VStack {
                HStack {
                    if meetPeopleEntity.isVoiceCallStatas  {
                        Text("●")
                            .font(.system(size: 10))
                            .fontWeight(.heavy)
                            .foregroundColor(.green)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    }
                    Text("\(meetPeopleEntity.age)歳")
                        .font(.system(size: 15))
                        .padding(EdgeInsets(top: 0, leading: meetPeopleEntity.isVoiceCallStatas ? 0 : 5, bottom: 0, trailing: 0))
                    Text(meetPeopleEntity.name)
                        .font(.system(size: 15))
                    Spacer()
                    Text(meetPeopleEntity.region)
                        .font(.system(size: 15))
                        .lineLimit(1)
                    Spacer()
                }
                Text(meetPeopleEntity.selfIntroduction)
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
        }
        .redacted(reason: isLoading ? [] : .placeholder)
        .shimmering(active: !isLoading, animation: !isLoading ? .easeOut(duration: 1.0) : .default)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
