//
//  AudioRecorderManager.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/20.
//

import AVFoundation
import Speech

final class AudioRecorderManager: NSObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false

    override init() {
        super.init()
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja_JP"))
        requestSpeechAuthorization()
    }


    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { [weak self] authStatus in
            guard let self = self else { return }
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("Speech recognition authorization granted")
                case .denied:
                    print("Speech recognition authorization denied")
                case .restricted:
                    print("Speech recognition restricted")
                case .notDetermined:
                    print("Speech recognition not determined")
                @unknown default:
                    fatalError()
                }
            }
        }
    }

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

    func startSpeechRecognition() {
        guard let recognizer = speechRecognizer,
              recognizer.isAvailable else {
            print("できてる？1 Speech recognition is not available")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        do {
            print("できてる？2")
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            print("できてる？3")
            recognitionTask = recognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
                guard let self = self else { return }
                print("できてる？4")
                var isFinal = false

                if let result = result {
                    print("できてる？5")
                    // 音声認識の結果を取得
                    let transcription = result.bestTranscription.formattedString
                    print("Transcription: \(transcription)")
                    // ここで取得した文字列を利用するか、保存するなどの処理を行います。

                    isFinal = result.isFinal
                }
                print("できてる？6")
                if error != nil || isFinal {
                    print("できてる？6")
                    self.stopSpeechRecognition()
                }
            }
            print("できてる？7")
            let recordingFormat = audioRecorder?.format
            audioRecorder?.record()
            audioRecorder?.delegate = self
            audioRecorder?.record(forDuration: 10)
            print("できてる？8")
            recognitionRequest?.shouldReportPartialResults = true
        } catch {
            print("できてる？9")
            print("Error starting speech recognition: \(error.localizedDescription)")
        }
    }

    func stopSpeechRecognition() {
        audioRecorder?.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
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
