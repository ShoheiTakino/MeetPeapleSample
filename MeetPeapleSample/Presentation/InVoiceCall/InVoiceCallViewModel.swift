//
//  InVoiceCallViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/11.
//

import Foundation

final class InVoiceCallViewModel: ObservableObject {

    @Published var isMicOn = true
    @Published var isSpeakerOn = false

    func tappedCloseButton() {

    }
}
