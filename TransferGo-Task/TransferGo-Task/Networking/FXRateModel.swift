//
//  FXRateModel.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import Foundation

struct FXRateModel: Decodable {
    let from: String
    let to: String
    let rate: Double
    let fromAmount: Double
    let toAmount: Double
}

enum Currencies: String, CaseIterable {
    case pln, eur, gbp, uah
    
    var country: String {
        switch self {
        case .pln:
            return "Poland"
        case .eur:
            return "Germany"
        case .gbp:
            return "Great Britain"
        case .uah:
            return "Ukraine"
        }
    }
    var name: String {
        switch self {
        case .pln:
            return "Polish zloty"
        case .eur:
            return "Euro"
        case .gbp:
            return "British Pound"
        case .uah:
            return "Hrivna"
            
        }
    }
    var flag: String {
        switch self {
        case .pln:
            return "PL-L"
        case .eur:
            return "DE-L"
        case .gbp:
            return "GB-L"
        case .uah:
            return "UA-L"
        }
    }
    var limitsForSending: Double {
        switch self {
        case .pln:
            return 20000
        case .eur:
            return 5000
        case .gbp:
            return 1000
        case .uah:
            return 50000
        }
    }
}
