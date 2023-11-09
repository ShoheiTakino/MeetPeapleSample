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
            PipContentView()
        }
    }
}

struct PipContentView: View {
    @State private var isPIPActive = false
    @State private var pipOffset: CGSize = CGSize(width: 0, height: 0) // 初期位置を左上に変更
    @State private var isPipFixed = false

    var body: some View {
        VStack {
            // 通常のコンテンツ
            Text("Main Content")
                .padding()

            // ピクチャーインピクチャー用のボタン
            Button(action: {
                isPIPActive.toggle()
            }) {
                Text("Toggle PiP")
                    .padding()
            }
            .pictureInPicture(isActive: $isPIPActive, offset: $pipOffset, isFixed: $isPipFixed)
        }
    }
}

extension View {
    func pictureInPicture(isActive: Binding<Bool>, offset: Binding<CGSize>, isFixed: Binding<Bool>) -> some View {
        return self.overlay(
            PictureInPictureView(isActive: isActive, offset: offset, isFixed: isFixed)
        )
    }
}

struct PictureInPictureView: View {
    @Binding var isActive: Bool
    @Binding var offset: CGSize
    @Binding var isFixed: Bool

    var body: some View {
        if isActive {
            // ピクチャーインピクチャーのビュー
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 60)
                .foregroundColor(.blue)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // ドラッグ中に位置を更新
                            if !isFixed {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            // ドラッグが終わったら位置を固定
                            isFixed = false
                        }
                )
                .overlay(
                    Button(action: {
                        isActive = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .padding(5)
                    .offset(x: 40, y: -25), alignment: .topTrailing
                )
                .onTapGesture {
                    // ピクチャーインピクチャーをアクティブにするトリガー
                    isActive.toggle()
                }
                .contentShape(Rectangle())
        } else {
            // ピクチャーインピクチャーが非アクティブの場合は空のビューを返す
            EmptyView()
        }
    }
}
