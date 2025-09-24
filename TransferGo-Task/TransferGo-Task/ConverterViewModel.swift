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
    @Published var fromAmountStr: String = "300.00"
    @Published var toAmountStr: String = "753.00"
    @Published var isSheetPresented: Bool = false
    @Published var isFrom: Bool = true
    @Published var rate: Double = 0.0
    
    @Published var searchedCurrency: String = ""
    
    private var pendingWorkItem: DispatchWorkItem?
    
    let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }
    
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
// fetching
extension ConverterViewModel {
    func debounceFetch(amountStr: String, isFrom: Bool) {
        pendingWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            Task {
                await self.fetchValue(amount: Double(amountStr) ?? 0, isFrom: isFrom)
            }
        }
        
        pendingWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
    
    @MainActor
    func fetchValue(amount: Double, isFrom: Bool) async {
        guard amount >= 0 else { return }
        
        if isFrom {
            guard amount < fromCurrency.limitsForSending else { return }
            let fetchedValue = await networkManager.fetchValueFromAPI(from: fromCurrency, amount: amount, to: toCurrency)
            guard let value = fetchedValue.amount, let rate = fetchedValue.rate else { return }
            self.toAmountStr = String(format: "%.2f", value)
            self.rate = rate
        } else {
            let fetchedValue = await networkManager.fetchValueFromAPI(from: toCurrency, amount: amount, to: fromCurrency)
            guard let value = fetchedValue.amount, let rate = fetchedValue.rate else { return }
            self.fromAmountStr = String(format: "%.2f", value)
            guard rate > 0 else { return }
            self.rate = 1 / rate
        }
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
    var filteredCurrencies: [Currencies] {
        guard !searchedCurrency.isEmpty else { return Currencies.allCases }
        let lowercasedSearch = searchedCurrency.lowercased()
        return Currencies.allCases.filter { currency in
            currency.rawValue.lowercased().contains(lowercasedSearch) ||
            currency.name.lowercased().contains(lowercasedSearch) ||
            currency.country.lowercased().contains(lowercasedSearch)
        }
    }
}
