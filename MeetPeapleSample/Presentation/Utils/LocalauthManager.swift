//
//  LocalauthManager.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/16.
//

import Foundation
import LocalAuthentication

enum AuthenticationState {
    case loggedin
    case loggedout
}

final class LocalauthManager {

    let context: LAContext = LAContext()
    let reason = "Face IDを使用する場合は設定より\nアクセスの許可を変更してください。"
    
    func auth() async throws -> Bool {
        do {
            return try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
        } catch let error {
            print(error.localizedDescription)
            // Fall back to a asking for username and password.
            // ...
            return false
        }
    }

    func confirmInitAuth(_ aaa: Bool) async throws -> Bool {
        do {
            try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
            UserDefaultsService.storeLocalAuth(aaa)
            return aaa
        } catch let error {
            print(error.localizedDescription)
            // Fall back to a asking for username and password.
            // ...
            return false
        }
    }
}
