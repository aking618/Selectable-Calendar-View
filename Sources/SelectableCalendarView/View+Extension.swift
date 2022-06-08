//
//  View+Extension.swift
//  SelectableCalendarView
//
//  Created by Shunzhe on 2022/04/19.
//

import Foundation
import SwiftUI

@available(iOS 15, *)
@available(macOS 12, *)
extension View {
    @ViewBuilder
    func addCircularBackground(isFilled: Bool, isSelected: Bool, backgroundColors: [Color]) -> some View {
        self
            .padding(9)
        #if os(macOS)
            .foregroundColor(Color(cgColor: .black))
        #elseif os(iOS)
            .foregroundColor(Color(uiColor: .systemBackground))
        #endif
            .background(
                appripriateView(for: backgroundColors)
                    .mask {
                        Circle()
                            .frame(width: 35, height: 35)
                    }
                    .opacity(isFilled ? 1.0 : 0.5)
                    .padding(isSelected ? 3 : 0)
//                    .foregroundColor(isSelected ? adjustedColor(gradient) : gradient)
            )
    }
    
    @ViewBuilder
    private func appripriateView(for colors: [Color]) -> some View {
        switch colors.count {
        case 0:
            EmptyView()
        case 1:
            if let color = colors.first {
                color
            } else {
                EmptyView()
            }
        default:
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
    }
    
    private func adjustedColor(_ input: Color) -> Color {
        input.opacity(0.8)
    }
}
