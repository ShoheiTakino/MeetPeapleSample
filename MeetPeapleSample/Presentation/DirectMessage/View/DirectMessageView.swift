//
//  DirectMessageView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/10.
//

import SwiftUI

struct DirectMessageView: View {
    var body: some View {
        VStack {
            // チャットメッセージの表示領域（ダミー）
            Text("Chat Messages Here")
            Spacer()
            // インプットバー
            ChatInputView()
        }
        .padding()
    }
}

struct ChatInputView: View {
    @State private var messageText: String = ""

    var body: some View {
        HStack {
            VStack {
                Spacer()
                TextEditor(text: $messageText)
                    .frame(height: 100)
                    .padding(10)
                    .background(.gray)
                    .cornerRadius(15)
            }
            VStack {
                Spacer()
                Button(action: {
                    // メッセージ送信の処理をここに追加
                    print("メッセージ送信: \(messageText)")
                    // 送信後にテキストをクリア
                    messageText = ""
                }) {
                    Text("送信")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
        }
        .padding()
    }
}


struct DirectMessage_Previews: PreviewProvider {
    static var previews: some View {
        DirectMessageView()
    }
}
