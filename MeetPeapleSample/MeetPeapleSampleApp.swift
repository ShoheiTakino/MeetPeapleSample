//
//  MeetPeapleSampleApp.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI

@main
struct MeetPeapleSampleApp: App {
    @State private var isScreenshotTaken = false
    var body: some Scene {
        WindowGroup {
            CalenderView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                    // スクリーンショットが撮られたときに実行される処理
                    print(#function, "aaa")
                    isScreenshotTaken = true
                }
                .alert(isPresented: $isScreenshotTaken) {
                    Alert(title: Text("⚠️警告"), message: Text("このアプリでは、スクリーンショットを撮ることは禁止されています。\n何度もスクリーンショットを撮ると大会の対象になります。\n皆様が安心してご利用していただけるようにご理解のほどよろしくお願いします。"), dismissButton: .default(Text("おけ"), action: {
                        isScreenshotTaken = false
                    }))
                }
        }
    }
}
