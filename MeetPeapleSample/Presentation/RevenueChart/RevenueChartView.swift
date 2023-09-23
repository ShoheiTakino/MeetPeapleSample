//
//  RevenueChartView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/20.
//

import SwiftUI
import Charts

struct RevenueChartView: View {

    struct MonthlyHoursOfSunshine: Identifiable {
        var id: ObjectIdentifier
        var date: Date
        var hoursOfSunshine: Double

        init(id: ObjectIdentifier, month: Int, hoursOfSunshine: Double) {
            self.id = id
            let calendar = Calendar.autoupdatingCurrent
            self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
            self.hoursOfSunshine = hoursOfSunshine
        }
    }


    var data: [MonthlyHoursOfSunshine] = [
        MonthlyHoursOfSunshine(id: ObjectIdentifier(AnyObject.self), month: 1, hoursOfSunshine: 74),
        MonthlyHoursOfSunshine(id: ObjectIdentifier(AnyObject.self),month: 2, hoursOfSunshine: 99),
        // ...
        MonthlyHoursOfSunshine(id: ObjectIdentifier(AnyObject.self),month: 12, hoursOfSunshine: 6)
    ]

    @StateObject private var viewModel = RevenueChartViewModel()
    @Binding var revenueForCalender: RevenueForCalender
    var body: some View {
        VStack {
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
            }.frame(width: .infinity, height: 400)
            Spacer()
        }
    }
}

struct RevenueChartView_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = RevenueForCalender(monthlyRevenue: 5000, monthlyPayment: 1000, dailyRevenuDataList: [])
        return RevenueChartView(revenueForCalender: .constant(mockData))
    }
}

