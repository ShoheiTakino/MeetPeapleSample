//
//  OtherUserProfileView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

struct OtherUserProfileView: View {
    private let imageNum: Int
    private let screen = UIScreen.main.bounds.width
    
    init(imageNum: Int) {
        self.imageNum = imageNum
    }
    
    var body: some View {
        VStack {
            ScrollView {
                Image("user_image_\(imageNum)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screen, height: screen)
                    .cornerRadius(20)
                Spacer()
            }
        }
    }
}

struct OtherUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserProfileView(imageNum: 0)
    }
}
