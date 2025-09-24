//
//  TextModifier.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import SwiftUI

struct TextModifier: ViewModifier {
    let font: Font
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
    }
}

extension View {
    func customText(font: Font, color: Color) -> some View {
        self.modifier(TextModifier(font: font, color: color))
    }
}

