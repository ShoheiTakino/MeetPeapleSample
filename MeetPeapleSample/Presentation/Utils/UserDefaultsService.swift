//
//  UserDefaultsService.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/16.
//

import Foundation

enum UserDefaultsKey: String {
    case isActivateLocalAuthKey = "isActivateLocalAuthKey"
}

struct UserDefaultsService {

    static let UD = UserDefaults.standard

    static func storeLocalAuth(_ isActive: Bool) {
        UD.set(isActive, forKey: UserDefaultsKey.isActivateLocalAuthKey.rawValue)
    }

    static func getIsLocalAuth() -> Bool {
        UD.bool(forKey: UserDefaultsKey.isActivateLocalAuthKey.rawValue)
    }
}
