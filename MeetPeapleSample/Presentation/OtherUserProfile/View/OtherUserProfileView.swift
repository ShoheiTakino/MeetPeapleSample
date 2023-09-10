//
//  OtherUserProfileView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct OtherUserProfileView: View {
    private let screen = UIScreen.main.bounds.width
    private var meetPeopleEntityList: [MeetPeopleEntity]
    private var selctedIndex: Int
    @State var bindingSelectedIndex = 0
    
    init(meetPeopleEntityList: [MeetPeopleEntity],
         selctedIndex: Int) {
        self.meetPeopleEntityList = meetPeopleEntityList
        self.selctedIndex = selctedIndex
    }
    
    var body: some View {
        TabView {
            ForEach(0..<meetPeopleEntityList.count, id: \.self) { index in
                PartnerProfileContent(meetPeopleEntity: meetPeopleEntityList[index])
            }
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct PartnerProfileContent: View {
    let screen = UIScreen.main.bounds.width
    var meetPeopleEntity: MeetPeopleEntity
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    Image(meetPeopleEntity.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screen, height: screen)
                        .cornerRadius(20)
                    HStack {
                        Button {

                        } label: {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        Spacer()
                        Button {

                        } label: {
                            Image(systemName: "chevron.right.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                }
                Spacer()
            }
        }
    }
}

//struct OtherUserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUserProfileView(imageNum: 0)
//    }
//}
