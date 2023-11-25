//
//  RevenueChartView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/20.
//

import SwiftUI
import Charts

struct RevenueChartView: View {

    @StateObject private var viewModel = RevenueChartViewModel()

    var body: some View {
        VStack {
            Chart {
                ForEach(0..<viewModel.monthlyData.count, id: \.self) { index in
                    BarMark(x: .value("通話", viewModel.monthlyData[index].voiceCall),
                            y: .value("通話ではない。", viewModel.monthlyData[index].chat))
                    .foregroundStyle(.cyan)
                    .position(by: .value("カテゴリー", viewModel.monthlyData[index].chat))
                }
            }
            .chartForegroundStyleScale ([
                        "通話": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
                    ])
                    .padding()
            .frame(height: 300)
        }
        .navigationBarTitle("Monthly Revenue Chart")
        .onAppear {
            viewModel.onApper()
        }
    }
}

struct RevenueChartView_Previews: PreviewProvider {
    static var previews: some View {
        RevenueChartView()
    }
}

