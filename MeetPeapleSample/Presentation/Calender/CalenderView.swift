//
//  CalenderView.swift
//  MeetPeapleSample
//
//  Created by 滝野翔平 on 2023/09/09.
//

import SwiftUI

enum Week: CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var title: String {
        switch self {
        case .sunday: return "日"
        case .monday: return "月"
        case .tuesday:  return "火"
        case .wednesday: return "水"
        case .thursday:  return "木"
        case .friday: return "金"
        case .saturday: return "土"
        }
    }
}

enum Month: CaseIterable {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december

    var title: String {
        switch self {
        case .january: return "1月"
        case .february: return "2月"
        case .march: return "3月"
        case .april: return "4月"
        case .may: return "5月"
        case .june: return "6月"
        case .july: return "7月"
        case .august: return "8月"
        case .september: return "9月"
        case .october: return "10月"
        case .november: return "11月"
        case .december: return "12月"
        }
    }
}

struct CalenderView: View {
    @State var selectedMonth = "9月"
    @State var selectedDay = "9"

    var body: some View {
        GeometryReader { geometory in
            VStack {
                Text("カレンダー")
                ScrollViewReader { monthReader in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<Month.allCases.count, id: \.self) { index in
                                Text(Month.allCases[index].title)
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                //                                    .foregroundColor(isSelectedMonth(Month.allCases[index].title) ? .white : .blue)
                                    .foregroundColor(isSelectedMonth(Month.allCases[index].title) ? .red : .blue)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .onTapGesture {
                                        selectedMonth = Month.allCases[index].title
                                    }
                            }
                            .id(selectedMonth)
                        }
                    }
                    .onAppear() {
                        withAnimation {
                            monthReader.scrollTo(selectedMonth, anchor: .center)
                        }
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                        ForEach(0..<Week.allCases.count, id: \.self) { index in
                            Text(Week.allCases[index].title)
                                .frame(width: geometory.size.width / 7, height: 40)
                                .foregroundColor(setWeeklyColor(Week.allCases[index].title))
                        }
                        ForEach(1..<31, id: \.self) { index in
                            Button {
                                selectedDay = "\(index)"
                            } label: {
                                VStack {
                                    Text("\(index)")
                                        .frame(width: geometory.size.width / 7, height: 40)
                                        .foregroundColor(isSelected("\(index)") ? .red : .black)
                                    Text("1,000円")
                                        .foregroundColor(isSelected("\(index)") ? .red : .black)
                                        .font(.system(size: 10))
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                }
                GetPointCard()
            }
        }
    }

    func setWeeklyColor(_ title: String) -> Color {
        switch title {
        case Week.sunday.title: return .red
        case Week.saturday.title: return .blue
        default: return .black
        }
    }

    func isSelectedMonth(_ title: String) -> Bool {
        selectedMonth == title
    }

    func isSelected(_ day: String) -> Bool {
        day == selectedDay
    }
}

struct GetPointCard: View {

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
                Text("チャット")
                    .fontWeight(.semibold)
                Spacer()
                Text("10,000pt")
                    .fontWeight(.medium)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Text("ビデオ")
                    .fontWeight(.semibold)
                Spacer()
                Text("10,000pt")
                    .fontWeight(.medium)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            HStack {
                Text("音声")
                    .fontWeight(.semibold)
                Spacer()
                Text("10,000pt")
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
