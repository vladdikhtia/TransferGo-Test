//
//  ConverterViewModel.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import Foundation

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

final class ConverterViewModel: ObservableObject {
    @Published var fromCurrency: Currencies = .pln
    @Published var toCurrency: Currencies = .uah
    @Published var tempCurrency: Currencies = .pln
    @Published var fromAmountStr: String = "300.00"
    @Published var toAmountStr: String = "753.00"
    @Published var isSheetPresented: Bool = false
    @Published var isFrom: Bool = true
    
    var isLimitReached: Bool {
        if let amount = Double(fromAmountStr) {
            return amount > fromCurrency.limitsForSending
        }
        return false
    }
    
    func swapCurrencies() {
        tempCurrency = fromCurrency
        fromCurrency = toCurrency
        toCurrency = tempCurrency
    }
}

// sheet
extension ConverterViewModel {
    func changeCurrency(currency: Currencies) {
        if isFrom {
            fromCurrency = currency
        } else {
            toCurrency = currency
        }
        isSheetPresented = false
    }
}
