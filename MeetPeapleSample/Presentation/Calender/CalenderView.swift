//
//  CalenderView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/09.
//

import SwiftUI

struct CalenderView: View {
    @StateObject private var viewModel = CalenderViewModel()
    var body: some View {
        VStack {
            CalendarTestView(selectedDate: $viewModel.isSelectedDate)
                .frame(height: 400)
            GetPointCard(dailyRevenuData: $viewModel.revenueForCalender.dailyRevenuDataList[viewModel.isSelectedDate])
            Spacer()
        }
        .navigationTitle(Text("報酬カレンダー"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: NavigationLink(destination: {
            RevenueChartView(revenueForCalender: $viewModel.revenueForCalender)
        }, label: {
            Image(systemName: "chart.line.uptrend.xyaxis")
        }))
    }
}

struct GetPointCard: View {
    @Binding var dailyRevenuData: DailyRevenuData
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "p.circle.fill")
                Text("今月の獲得ポイントの内訳")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Image(systemName: "bubble.left")
                Text("チャット")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(dailyRevenuData.chat)" + "pt")
                    .fontWeight(.medium)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Image(systemName: "camera")
                Text("ビデオ")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(dailyRevenuData.video)" + "pt")
                    .fontWeight(.medium)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Image(systemName: "mic")
                Text("音声")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(dailyRevenuData.voiceCall)" + "pt")
                    .fontWeight(.medium)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 20, trailing: 0))
        }
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .background(.blue.opacity(0.7))
        .cornerRadius(20)
        .frame(width: 300, height: 250)
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}
