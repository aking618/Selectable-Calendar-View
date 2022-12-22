//
//  CalendarView.swift
//  SelectableCalendarView
//
//  Created by Shunzhe on 2022/04/19.
//

import SwiftUI

@available(macOS 13, *)
@available(iOS 16, *)
public struct SelectableCalendarView: View {
    
    // 表示される月の任意の日に設定します（通常は1日）
    @State var monthToDisplay: Date
    
    // The date user selected
    @Binding var dateSelected: Date
    
    // If user can switch to previous month or next month
    var allowSwitchMonth: Bool
    
    // Whether to show the month label
    var showMonthLabel: Bool
    
    // Provide a function; this class will ask if a specific date circle should be filled in (a darker color).
    var isDateCircleFilled: ((Date) -> Bool)?
    
    var colorForDate: ((Date) -> Color)
    
    var backgroundForDate: ((Date) -> AnyView)?
    
    public init(
        monthToDisplay: Date,
        dateSelected: Binding<Date>,
        allowSwitchMonth: Bool = true,
        showMonthLabel: Bool = true,
        dateBackgroundBuilder: ((Date) -> AnyView)?,
        colorForDate: @escaping ((Date) -> Color) = { _ in return .primary}
    ) {
        self._monthToDisplay = .init(initialValue: monthToDisplay)
        self._dateSelected = dateSelected
        self.allowSwitchMonth = allowSwitchMonth
        self.showMonthLabel = showMonthLabel
        self.backgroundForDate = dateBackgroundBuilder
        self.colorForDate = colorForDate
    }
    
    @ViewBuilder
    private func backgroundBuilder(_ date: Date) -> some View {
        if let backgroundForDate = backgroundForDate {
            backgroundForDate(date)
        } else {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 35, height: 35)
        }
    }
    
    public var body: some View {
        VStack {
            HStack {
                if allowSwitchMonth {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            monthToDisplay = monthToDisplay.getLastMonth()
                        }
                    if monthToDisplay.getMonthString() != Date().getMonthString() {
                        // Show the user return to current month button
                        Image(systemName: "arrow.counterclockwise.circle")
                            .font(.system(size: 30))
                            .onTapGesture {
                                monthToDisplay = Date()
                            }
                    }
                }
                Spacer()
                if showMonthLabel {
                    Text(monthToDisplay.getMonthString())
                        .font(.title2)
                }
                Spacer()
                if allowSwitchMonth {
                    Image(systemName: "arrow.right.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            monthToDisplay = monthToDisplay.getNextMonth()
                        }
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                // Week day labels
                ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { weekdayName in
                    Text(weekdayName)
                        .font(.system(size: 15).bold())
                }
                // Day number text
                Section {
                    ForEach(monthToDisplay.getDaysForMonth(), id: \.self) { date in
                        ZStack {
                            backgroundBuilder(date)
                            Text("\(date.getDayNumber())")
                                .foregroundColor(colorForDate(date))
                                .font(.system(size: 15))
                                .bold(date.isSameDay(comparingTo: dateSelected))
                        }
                        .id(date)
                        .opacity(Calendar.current.isDate(date, equalTo: monthToDisplay, toGranularity: .month) ? 1.0 : 0.5)
                        .onTapGesture {
                            self.dateSelected = date
                        }
                    }
                }
            }
        }
    }
    
}

@available(macOS 13, *)
@available(iOS 16, *)
struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
