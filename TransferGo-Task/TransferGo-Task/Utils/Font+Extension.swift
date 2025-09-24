//
//  Font+Extension.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import SwiftUI

extension Font {
    static var headingL: Font {
        return .custom("Inter-Bold", fixedSize: 32)
    }
    static var headingM: Font {
        return .custom("Inter-Bold", fixedSize: 24)
    }
    static var bodyLBold: Font {
        return .custom("Inter-Bold", fixedSize: 16)
    }
    static var bodyMBold: Font {
        return .custom("Inter-Bold", fixedSize: 14)
    }
    static var bodyMRegular: Font {
        return .custom("Inter-Regular", fixedSize: 14)
    }
    
    static var bodyXSBold: Font {
        return .custom("Inter-Bold", fixedSize: 10)
    }
    static var bodySRegular: Font {
        return .custom("Inter-Regular", fixedSize: 12)
    }
}
