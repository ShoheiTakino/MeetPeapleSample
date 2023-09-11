//
//  WithdrwledView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/11.
//

import SwiftUI

struct WithdrwledView: View {
    @State private var inputWithdrawalReason = ""
    let maxWithdrowalReasonCount = 300
    @State private var isPresented = false
    @State private var isConfirmWithdrawal = false
    var body: some View {
        VStack {
            Spacer()
            Text("※退会理由の入力にご協力ください。\n退会ボタンをタップすると退会が完了します。")
                .font(.system(size: 16))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Text("※のこり\(maxWithdrowalReasonCount - inputWithdrawalReason.count)文字まで")
                .foregroundColor(.red)
                .fontWeight(.semibold)
                .font(.system(size: 14))
            TextEditor(text: $inputWithdrawalReason)
                .frame(width: 250, height: 200)
                .textFieldStyle(.plain)

            Button {
                let _ = print("aa")
                isConfirmWithdrawal = true
            } label: {
                Text("退会")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
                    .background(.red)
                    .cornerRadius(20)

            }
            .fullScreenCover(isPresented: $isPresented) {
                WithdrwledAfterView()
            }
            Spacer()
        }
        .alert(isPresented: $isConfirmWithdrawal) {
            Alert(title: Text("退会しますか？"), message: Text("※退会処理が完了すると、データを復元できません。\nそれでも退会しますか？") ,primaryButton: .default(Text("キャンセル")), secondaryButton: .destructive(Text("退会する"), action: {
                isPresented = true
            }))
        }
    }
}

struct WithdrwledAfterView: View {
    var body: some View {
        VStack {
            Text("退会処理が完了しました。/nご利用ありがとうございました。")
        }
    }
}

struct WithdrwledView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrwledView()
    }
}
