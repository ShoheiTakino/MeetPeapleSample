//
//  InVoiceCallView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/11.
//

import SwiftUI

struct InVoiceCallView: View {
    @StateObject private var viewModel = InVoiceCallViewModel()
    var body: some View {
        ZStack {
            Image("user_image_1").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea()
                .blur(radius: 5.0, opaque: false)
            Color.gray.opacity(0.9).ignoresSafeArea()
            VStack {
                VStack {
                    Text("山田 花子")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Button {

                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                HStack {
                    Button {
                        viewModel.isMicOn.toggle()
                    } label: {
                        Image(systemName: viewModel.isMicOn ? "mic" : "mic.slash.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 0))
                    }
                    Button {

                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
                    }
                    Button {
                        viewModel.isSpeakerOn.toggle()
                    } label: {
                        Image(systemName: viewModel.isSpeakerOn ? "speaker.wave.3.fill" : "speaker.slash.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 20))
                    }
                }
            }
        }
    }
}

struct InVoiceCallView_Previews: PreviewProvider {
    static var previews: some View {
        InVoiceCallView()
    }
}
