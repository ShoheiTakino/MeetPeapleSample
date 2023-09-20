//
//  RevenueChartView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/20.
//

import SwiftUI

struct RevenueChartView: View {
    @StateObject private var viewModel = RevenueChartViewModel()
    @Binding var revenueForCalender: RevenueForCalender
    var body: some View {
        Text("RevenueChartView")
    }
}
