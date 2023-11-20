//
//  AudioRecorderManager.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/20.
//

import AVFoundation

final class AudioRecorderManager {
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    var isRecording = false

    func confrimUseMic() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // マイクの使用が許可された場合の処理
                print("Microphone permission granted")
            } else {
                // マイクの使用が拒否された場合や許可ダイアログが表示されなかった場合の処理
                print("Microphone permission denied")
            }
        }
    }

    func isUseMice() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // マイクの使用が許可された場合の処理
                print("Microphone permission granted")
            } else {
                // マイクの使用が拒否された場合や許可ダイアログが表示されなかった場合の処理
                print("Microphone permission denied")
            }
        }
    }

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)

            let audioSettings = [
                AVFormatIDKey: kAudioFormatMPEG4AAC,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]

            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentPath.appendingPathComponent("recording.m4a")

            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: audioSettings)
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error starting recording: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false

        do {
            let recordedData = try Data(contentsOf: (audioRecorder?.url)!)
            UserDefaultsService.storeRecording(recordedData)
        } catch {
            print("Error playing recording: \(error.localizedDescription)")
        }
    }

    func playVoice(_ data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing recording: \(error.localizedDescription)")
        }
    }
}
