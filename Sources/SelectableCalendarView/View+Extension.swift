//
//  View+Extension.swift
//  SelectableCalendarView
//
//  Created by Shunzhe on 2022/04/19.
//

import Foundation
import SwiftUI

public struct ColorPair {
    public let standard: Color
    
    public init(standard: Color) {
        self.standard = standard
    }
    
    var highlighted: Color {
        return standard.opacity(0.7)
    }
    
}

@available(iOS 15, *)
@available(macOS 12, *)
extension View {
    @ViewBuilder
    func addCircularBackground(isFilled: Bool, isSelected: Bool, colorPair: ColorPair) -> some View {
        self
            .padding(9)
        #if os(macOS)
            .foregroundColor(Color(cgColor: .black))
        #elseif os(iOS)
            .foregroundColor(Color(uiColor: .systemBackground))
        #endif
            .background(
                Circle()
                    .foregroundColor(isSelected ? colorPair.highlighted : colorPair.standard)
                    .frame(width: 35, height: 35)
                    .opacity(isFilled ? 1.0 : 0.5)
                    .padding(isSelected ? 3 : 0)
                    .overlay(
                        Circle()
                            .stroke(colorPair.highlighted, lineWidth: isSelected ? 2 : 0)
                    )
            )
    }
}
