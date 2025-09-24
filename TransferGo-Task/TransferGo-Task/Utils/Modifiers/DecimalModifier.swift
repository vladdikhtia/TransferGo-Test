//
//  DecimalModifier.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import SwiftUI

struct MaxLengthAndDecimalModifier: ViewModifier {
    @Binding var text: String
    let maxLength: Int
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) {
                var filtered = text.replacingOccurrences(of: ",", with: ".")
                
                let parts = filtered.components(separatedBy: ".")
                if parts.count > 2 {
                    filtered = parts[0] + "." + parts[1]
                }
                filtered = filtered.filter { "0123456789.".contains($0) }
                let limited = String(filtered.prefix(maxLength))
                if text != limited {
                    text = limited
                }
            }
    }
}

extension View {
    func maxLengthDecimal(_ text: Binding<String>, _ length: Int) -> some View {
        self.modifier(MaxLengthAndDecimalModifier(text: text, maxLength: length))
    }
}
