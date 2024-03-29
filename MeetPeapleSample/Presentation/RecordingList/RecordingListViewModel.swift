//
//  RecordingListViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/20.
//

import Foundation

final class RecordingListViewModel: ObservableObject {

    @Published var recordingDataList: [[Data:String]] = UserDefaultsService.getRecordingStringAndDataList()
    @Published var isNowRecording = false
    @Published var voiceText = ""
    private let audioRecorderManager = AudioRecorderManager()

    init() {
        audioRecorderManager.confrimUseMic()
    }

    func onAppear() {
        recordingDataList = UserDefaultsService.getRecordingStringAndDataList()
    }

    func tappedStartRecordingButton() {
        if isNowRecording { return }
        isNowRecording = true
//        audioRecorderManager.startRecording()
//        audioRecorderManager.startSpeechRecognition()
        do {
            try audioRecorderManager.startRecognition()
        } catch {
            print("無理やった")
        }
    }

    func tappedStopRecordingButton() {
        isNowRecording = false
//        audioRecorderManager.stopRecording()
        audioRecorderManager.stopSpeechRecognition()
    }

    func tappedPlayRecording(_ voiceData: Data) {
        audioRecorderManager.playVoice(voiceData)
    }

    func tappedRemoveRecordingDataListButton() {
        UserDefaultsService.removeRecordingStringList()
        recordingDataList = []
    }
}
