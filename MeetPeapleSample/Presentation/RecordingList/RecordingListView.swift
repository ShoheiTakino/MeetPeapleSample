//
//  RecordingListView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/20.
//

import SwiftUI

struct RecordingListView: View {

    @StateObject private var viewModel = RecordingListViewModel()

    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(0..<viewModel.recordingDataList.count, id: \.self) { index in
                        RecordingStringListItem(recordingString: $viewModel.recordingDataList[index]) { data in
//                            viewModel.tappedPlayRecording(data)
                        }
                    }
                }
                if viewModel.recordingDataList.isEmpty {
                    Text("録音なし")
                }
            }
            HStack {
                Button {
                    viewModel.tappedStartRecordingButton()
                } label: {
                    Text("録音する")
                        .frame(width: 100, height: 40)
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 0))
                }
                Spacer()
                VStack {
                    Text(viewModel.isNowRecording ? "On" : "OFF")
                    Button {
                        viewModel.tappedRemoveRecordingDataListButton()
                    } label: {
                        Text("消すよ")
                    }
                }
                Spacer()
                Button {
                    viewModel.tappedStopRecordingButton()
                } label: {
                    Text("保存する")
                        .frame(width: 100, height: 40)
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 10))
                }
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct RecordingListItem: View {

    @Binding var recordingData: Data
    let action: (Data) -> Void

    var body: some View {
        HStack {
            Button {
                action(recordingData)
            } label: {
                Text("再生する")
            }
        }
    }
}


struct RecordingStringListItem: View {

    @Binding var recordingString: String
    let action: (String) -> Void

    var body: some View {
        HStack {
            Button {
                action(recordingString)
            } label: {
                Text(recordingString)
            }
        }
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView()
    }
}
