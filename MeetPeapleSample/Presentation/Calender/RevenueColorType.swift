//
//  RevenueColorType.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/11/25.
//

import SwiftUI

enum RevenueEnum {
    case voiceCall
    case chat
    case image
    case video

    var barColor: Color {
        switch self {
        case .voiceCall: return .green
        case .chat: return .yellow
        case .image: return .red
        case .video: return .purple
        }
    }
}
