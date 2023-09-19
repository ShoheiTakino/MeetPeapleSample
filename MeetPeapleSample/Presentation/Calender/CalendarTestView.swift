//
//  CalendarTestView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/19.
//

import SwiftUI
import FSCalendar

struct CalendarTestView: UIViewRepresentable {

    func makeCoordinator() -> Coordinator{
         return Coordinator(self)
     }
    
    @Binding var selectedDate: Date
    func makeUIView(context: Context) -> UIView {

        typealias UIViewType = FSCalendar

        let fsCalendar = FSCalendar()

        fsCalendar.delegate = context.coordinator
        fsCalendar.dataSource = context.coordinator

        fsCalendar.scrollDirection = .horizontal //スクロールの方向
        fsCalendar.scope = .month //表示の単位（週単位 or 月単位）
        fsCalendar.locale = Locale(identifier: "ja") //表示の言語の設置（日本語表示の場合は"ja"）
        //ヘッダー
        fsCalendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20) //ヘッダーテキストサイズ
        fsCalendar.appearance.headerDateFormat = "yyyy/MM" //ヘッダー表示のフォーマット
        fsCalendar.appearance.headerTitleColor = UIColor.label //ヘッダーテキストカラー
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0 //前月、翌月表示のアルファ量（0で非表示）
        //曜日表示
        fsCalendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 20) //曜日表示のテキストサイズ
        fsCalendar.appearance.weekdayTextColor = .darkGray //曜日表示のテキストカラー
        fsCalendar.appearance.titleWeekendColor = .red //週末（土、日曜の日付表示カラー）
        //カレンダー日付表示
        fsCalendar.appearance.titleFont = UIFont.systemFont(ofSize: 16) //日付のテキストサイズ
        fsCalendar.appearance.titleFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold) //日付のテキスト、ウェイトサイズ
        fsCalendar.appearance.todayColor = .clear //本日の選択カラー
        fsCalendar.appearance.titleTodayColor = .blue //本日のテキストカラー

//        fsCalendar.appearance.selectionColor = .clear //選択した日付のカラー
//        fsCalendar.appearance.borderSelectionColor = .blue //選択した日付のボーダーカラー
//        fsCalendar.appearance.titleSelectionColor = .black //選択した日付のテキストカラー

//        fsCalendar.appearance.borderRadius = 0 //本日・選択日の塗りつぶし角丸量

        return fsCalendar
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
         var parent:CalendarTestView

         init(_ parent:CalendarTestView){
             self.parent = parent
         }

         func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             parent.selectedDate = date
             print(#function, date)
         }
     }
}

