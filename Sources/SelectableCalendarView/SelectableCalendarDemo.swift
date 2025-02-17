//
//  SwiftUIView.swift
//  
//
//  Created by Ayren King on 12/22/22.
//

import SwiftUI

@available(macOS 13, *)
@available(iOS 16, *)
public struct SelectableCalendarViewDemo: View {
    @State var date: Date = Date()
    
    public var body: some View {
        NavigationView {
            VStack {
                Text("Currently selected: \(date.getDayNumber())")
                SelectableCalendarView(monthToDisplay: Date(), dateSelected: $date, dateBackgroundBuilder: nil,
                                       dateForgroundBuilder: {date in
                    AnyView(NavigationLink(
                        destination: Text("\(date.getDayNumber())"),
                        label: {
                            Text("\(date.getDayNumber())")
                        }))
                }
                ) { date in
                    date.isSameDay(comparingTo: self.date) ? .green : .primary
                }
            }
        }
    }
}

@available(macOS 13, *)
@available(iOS 16, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableCalendarViewDemo()
    }
}
