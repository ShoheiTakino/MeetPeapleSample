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
    //音声認識で使用
    //認識言語は日本語設定
    private let recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja_JP"))!
    //入力に使うAVAudioEngine
    private var audioEngine: AVAudioEngine!
    //バッファの音声を音声認識に使うリクエスト
    private var recognitionReq: SFSpeechAudioBufferRecognitionRequest?
    private var isRecording = false

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

    func startRecognition() throws {
        audioEngine = AVAudioEngine()
        // もし前回の音声認識タスクが実行中ならキャンセル
          if let recognitionTask = self.recognitionTask {
              recognitionTask.cancel()
              self.recognitionTask = nil
          }
          //一旦TextViewの内容をクリア

          // 音声認識リクエストの作成
          recognitionReq = SFSpeechAudioBufferRecognitionRequest()
          guard let recognitionReq = recognitionReq else { return }
          //途中の音声認識の結果も出力するように設定
          recognitionReq.shouldReportPartialResults = true

          // audioSessionのインスタンス取得(シングルトン)
          let audioSession = AVAudioSession.sharedInstance()
          //audiosessionの設定、.recordで入力に、.mesurementで測定モードへ、.mixWithOthersは他のアプリのaudiosessionと同時使用可能としている
          try audioSession.setCategory(.record, mode: .measurement, options: .mixWithOthers)
          //audiosessionをアクティブに、.notifyOthersOnDeactivationは他のアプリにAudioSessionを無効にしたことを伝える。
          //セッションが終わると他のアプリはAudioSessionを開始できる
          try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

          // マイク入力の設定
          let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
          audioEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: recordingFormat) { (buffer, time) in
              //音声認識のバッファーセット
              recognitionReq.append(buffer)
          }
          //audioEngineを開始(入力)
          try audioEngine.start()

          //音声認識タスクを処理
          recognitionTask = recognizer.recognitionTask(with: recognitionReq, resultHandler: { (result, error) in
              //停止時はエラーで帰ってくる
              if let error = error {
                  print("\(error)")
                  //システム音を鳴らすなどあればaudiosessionをもとに戻す
                  do{
                      try audioSession.setCategory(.soloAmbient, mode: .default, options: .mixWithOthers)
                  }catch{
                      print(error)
                  }
              } else {
                  DispatchQueue.main.async {
                      UserDefaultsService.storeRecordingString(result?.bestTranscription.formattedString ?? "できへん")
                  }
              }
          })
    }

    //音声認識の停止
    func stopLiveTranscription() {
        //audioEngineの停止
        audioEngine.stop()
        //音声認識要求も停止
        recognitionReq?.endAudio()
        recognitionTask?.cancel()
        //audioEngine
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.inputNode.reset()
        recognitionTask = nil
        recognitionReq = nil

    }

    func startSpeechRecognition() {
        guard let recognizer = speechRecognizer,
              recognizer.isAvailable else { return }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        do {
            try AVAudioSession.sharedInstance().setCategory(.record, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            recognitionTask = recognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
                guard let self = self else { return }
                var isFinal = false
                if let result = result {
                    // 音声認識の結果を取得
                    let transcription = result.bestTranscription.formattedString
                    print("Transcription: \(transcription)")
                    // ここで取得した文字列を利用するか、保存するなどの処理を行います。
                    UserDefaultsService.storeRecordingString(transcription)
                    isFinal = result.isFinal
                }
                if error != nil || isFinal {
                    self.stopSpeechRecognition()
                }
            }
            let recordingFormat = audioRecorder?.format
            audioRecorder?.record()
            audioRecorder?.delegate = self
            audioRecorder?.record(forDuration: 10)
            recognitionRequest?.shouldReportPartialResults = true
        } catch {
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
