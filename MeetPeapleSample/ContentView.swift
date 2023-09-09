//
//  ContentView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/05/08.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var password = ""
    @State private var isScreenshotTaken = false
    var body: some View {
        ZStack {
            VStack {
                SecureField("Password", text: $password)
                    .onTapGesture {
                        print("sfsfdfsdfsdfsd")
                    }
                    .textFieldStyle(.plain)
                    .padding()
                    .frame(width: 400, height: 400)
            }
            .background(
                Color.black // スクリーンショットを撮ったときの背景色を黒くする
                    .opacity(0.01) // ほとんど透明にする
                    .onAppear {
                    }
            )
            Image("user_image_1")
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
