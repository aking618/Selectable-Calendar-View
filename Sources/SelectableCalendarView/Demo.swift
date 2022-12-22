//
//  SwiftUIView.swift
//  
//
//  Created by Ayren King on 12/22/22.
//

import SwiftUI

@available(macOS 13, *)
@available(iOS 16, *)
public struct Demo: View {
    @State var date: Date = Date()
    
    public var body: some View {
        VStack {
            Text("Currently selected: \(date.getDayNumber())")
            SelectableCalendarView(monthToDisplay: Date(), dateSelected: $date, dateBackgroundBuilder: nil)
        }
    }
}

@available(macOS 13, *)
@available(iOS 16, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
