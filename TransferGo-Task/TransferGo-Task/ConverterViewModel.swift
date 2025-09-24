//
//  ConverterViewModel.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import Foundation

final class ConverterViewModel: ObservableObject {
    @Published var fromCurrency: Currencies = .pln
    @Published var toCurrency: Currencies = .uah
    @Published var tempCurrency: Currencies = .pln
    @Published var fromAmountStr: String = "100.00"
    @Published var toAmountStr: String = "753.00"
}
