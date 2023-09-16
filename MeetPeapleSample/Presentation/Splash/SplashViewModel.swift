//
//  SplashViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/16.
//

import Foundation
import SwiftUI

@MainActor
final class SplashViewModel: ObservableObject {

    @Published var isLocalAuthLogin = false
    private let localAuth = LocalauthManager()

    init() {
        localAuthRequest()
    }

    func localAuthRequest() {
        if UserDefaultsService.getIsLocalAuth() {
            print(#function, "FaceID OK")
            Task {
                isLocalAuthLogin = try await localAuth.auth()
            }
            return
        }
        print(#function, "FaceID なし")
        isLocalAuthLogin = true
    }
}
