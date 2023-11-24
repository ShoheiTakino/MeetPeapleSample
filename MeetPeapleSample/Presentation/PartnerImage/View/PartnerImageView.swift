//
//  PartnerImageView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/09.
//

import SwiftUI

struct PartnerImageView: View {
    private let imageName: String
    @Environment(\.presentationMode) var presentationMode
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width)
            .gesture(DragGesture().onEnded { value in
                if value.translation.width > 100 {
                    // 画面の左から右にスワイプで前の画面に戻る
                    presentationMode.wrappedValue.dismiss()
                }
            })
    }
}

struct PartnerImageView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerImageView(imageName: "user_image_1")
    }
}
