//
//  CalenderViewModel.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/09.
//

import Foundation

final class CalenderViewModel: ObservableObject {

    @Published var isSelectedDate: Int = 1
    @Published var revenueForCalender = RevenueForCalender(monthlyRevenue: 0, monthlyPayment: 0, dailyRevenuDataList: [])

    init() {
        setCalenderData()
    }

    func setCalenderData() {
        revenueForCalender = createMockRevenueForCalendar()
    }

    func createMockDailyRevenueData() -> [DailyRevenuData] {
        var mockData: [DailyRevenuData] = []

        // ダミーデータの生成
        for day in 1...32 {
            let revenue = Int.random(in: 1000...5000)
            let payment = Int.random(in: 100...1000)
            let chat = Int.random(in: 10...50)
            let voiceCall = Int.random(in: 5...30)
            let live = Int.random(in: 1...10)
            let gift = Int.random(in: 20...100)
            let image = Int.random(in: 5...30)
            let video = Int.random(in: 2...20)
            let others = Int.random(in: 5...20)

            let dailyData = DailyRevenuData(day: day, revenue: revenue, payment: payment, chat: chat, voiceCall: voiceCall, live: live, gift: gift, image: image, video: video, others: others)
            mockData.append(dailyData)
        }

        return mockData
    }

    func createMockRevenueForCalendar() -> RevenueForCalender {
        let dailyDataList = createMockDailyRevenueData()
        let totalRevenue = dailyDataList.map { $0.revenue }.reduce(0, +)
        let totalPayment = dailyDataList.map { $0.payment }.reduce(0, +)

        return RevenueForCalender(monthlyRevenue: totalRevenue, monthlyPayment: totalPayment, dailyRevenuDataList: dailyDataList)
    }
}

struct DailyRevenuData {
    var id = UUID()
    let day: Int
    let revenue: Int
    let payment: Int
    let chat: Int
    let voiceCall: Int
    let live: Int
    let gift: Int
    let image: Int
    let video: Int
    let others: Int
}

struct RevenueForCalender {
    let monthlyRevenue: Int
    let monthlyPayment: Int
    var dailyRevenuDataList: [DailyRevenuData]
}
