//
//  RecordingListViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/20.
//

import Foundation

final class RecordingListViewModel: ObservableObject {

    @Published var recordingDataList: [Data] = UserDefaultsService.getRecordingDataList()
    @Published var isNowRecording = false
    private let audioRecorderManager = AudioRecorderManager()

    init() {
        audioRecorderManager.confrimUseMic()
    }

    func tappedStartRecordingButton() {
        if isNowRecording { return }
        isNowRecording = true
        audioRecorderManager.startRecording()
    }

    func tappedStopRecordingButton() {
        isNowRecording = false
        audioRecorderManager.stopRecording()
    }

    func tappedPlayRecording(_ voiceData: Data) {
        audioRecorderManager.playVoice(voiceData)
    }

    func tappedRemoveRecordingDataListButton() {
        UserDefaultsService.removeRecordingDataList()
        recordingDataList = []
    }
}
