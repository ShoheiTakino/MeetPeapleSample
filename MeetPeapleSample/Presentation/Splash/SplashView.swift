//
//  SplashView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/16.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        VStack {
            Text("Splash!!!")
                .fontWeight(.bold)
                .font(.system(size: 30))
        }
        .fullScreenCover(isPresented: $viewModel.isLocalAuthLogin) {
            MainTabView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
