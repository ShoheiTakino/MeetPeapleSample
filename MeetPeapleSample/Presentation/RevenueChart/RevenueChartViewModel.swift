//
//  RevenueChartViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/20.
//

import Foundation

final class RevenueChartViewModel: ObservableObject {
    @Published var monthlyData: [DailyRevenuData] = []

    func onApper() {
        monthlyData = generateMockData()
    }


    func generateMockData() -> [DailyRevenuData] {
        var mockData: [DailyRevenuData] = []
        for day in 1...30 {
            let revenue = Int.random(in: 100...500)
            let payment = Int.random(in: 20...100)
            let chat = Int.random(in: 10...50)
            let voiceCall = Int.random(in: 5...30)
            let live = Int.random(in: 0...20)
            let gift = Int.random(in: 0...10)
            let image = Int.random(in: 0...15)
            let video = Int.random(in: 0...10)
            let others = Int.random(in: 0...10)

            let dailyData = DailyRevenuData(day: day, revenue: revenue, payment: payment, chat: chat, voiceCall: voiceCall, live: live, gift: gift, image: image, video: video, others: others)
            mockData.append(dailyData)
        }
        return mockData
    }
}
