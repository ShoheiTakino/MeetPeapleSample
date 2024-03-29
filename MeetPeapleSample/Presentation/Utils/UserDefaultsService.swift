//
//  UserDefaultsService.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/16.
//

import Foundation

enum UserDefaultsKey: String {
    case isActivateLocalAuthKey = "isActivateLocalAuthKey"
    case recordingDataListKey = "recordingDataListKey"
    case recordingStringListKey = "recordingStringListKey"
    case recordingTappleListKey = "recordingTappleListKey"
}

struct UserDefaultsService {

    static let UD = UserDefaults.standard

    static func storeLocalAuth(_ isActive: Bool) {
        UD.set(isActive, forKey: UserDefaultsKey.isActivateLocalAuthKey.rawValue)
    }

    static func getIsLocalAuth() -> Bool {
        UD.bool(forKey: UserDefaultsKey.isActivateLocalAuthKey.rawValue)
    }

    static func storeRecording(_ data: Data) {
        var recordingDataList = getRecordingDataList()
        recordingDataList.append(data)
        UD.set(recordingDataList, forKey: UserDefaultsKey.recordingDataListKey.rawValue)
    }

    static func getRecordingDataList() -> [Data] {
        UD.array(forKey: UserDefaultsKey.recordingDataListKey.rawValue) as? [Data] ?? []
    }

    static func removeRecordingDataList() {
        UD.removeObject(forKey: UserDefaultsKey.recordingDataListKey.rawValue)
    }

    static func storeRecordingString(_ data: String) {
        var recordingDataList = getRecordingStringList()
        recordingDataList.append(data)
        UD.set(recordingDataList, forKey: UserDefaultsKey.recordingStringListKey.rawValue)
    }

    static func getRecordingStringList() -> [String] {
        UD.array(forKey: UserDefaultsKey.recordingStringListKey.rawValue) as? [String] ?? []
    }

    static func removeRecordingStringList() {
        UD.removeObject(forKey: UserDefaultsKey.recordingStringListKey.rawValue)
    }

    static func storeRecordingStringAndDataList(_ data: Data, text: String) {
        var recordingDataList = getRecordingStringAndDataList()
        let tapple = [data:text]
        recordingDataList.append(tapple)
        UD.set(recordingDataList, forKey: UserDefaultsKey.recordingTappleListKey.rawValue)
    }

    static func getRecordingStringAndDataList() -> [[Data: String]] {
        UD.array(forKey: UserDefaultsKey.recordingTappleListKey.rawValue) as? [[Data: String]] ?? [[:]]
    }

    static func removeRecordingStringAndDataList() {
        UD.removeObject(forKey: UserDefaultsKey.recordingTappleListKey.rawValue)
    }
}
