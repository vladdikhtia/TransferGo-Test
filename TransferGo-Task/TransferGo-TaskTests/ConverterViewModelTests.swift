//
//  ConvdrterViewModelTests.swift
//  TransferGo-TaskTests
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import XCTest
@testable import TransferGo_Task

final class ConverterViewModelTests: XCTestCase {
    
    var mockNetwork: MockNetworkManager!
    var viewModel: ConverterViewModel!
    
    override func setUpWithError() throws {
        mockNetwork = MockNetworkManager()
        viewModel = ConverterViewModel(networkManager: mockNetwork)
    }
    
    override func tearDownWithError() throws {
        mockNetwork = nil
        viewModel = nil
    }
    
    func test_swapCurrencies_changesFromAndTo() {
        // Given
        viewModel.fromCurrency = .pln
        viewModel.toCurrency = .uah
        
        // When
        viewModel.swapCurrencies()
        
        // Then
        XCTAssertEqual(viewModel.fromCurrency, .uah)
        XCTAssertEqual(viewModel.toCurrency, .pln)
    }
    
    func test_fetchValueFrom_updatesToAmountAndRate() async {
        // Given
        viewModel.fromCurrency = .pln
        viewModel.toCurrency = .uah
        
        // When
        await viewModel.fetchValue(amount: 100, isFrom: true)
        
        // Then
        XCTAssertEqual(viewModel.toAmountStr, "750.00")
        XCTAssertEqual(viewModel.rate, 7.5)
    }
    
    func test_debounceFetch_callsFetchValue() async {
        // Given
        viewModel.fromCurrency = .pln
        viewModel.toCurrency = .uah
        
        // When
        viewModel.debounceFetch(amountStr: "100", isFrom: true)
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        // Then
        XCTAssertEqual(viewModel.toAmountStr, "750.00")
        XCTAssertEqual(viewModel.rate, 7.5)
    }
    
    func test_isLimitReached_returnsTrueIfAboveLimit() {
        // Given
        viewModel.fromCurrency = .pln
        viewModel.fromAmountStr = "30000"
        
        // Then
        XCTAssertTrue(viewModel.isLimitReached)
    }
    
    func test_changeCurrency_updatesCorrectCurrency() {
        // Given
        viewModel.isFrom = true
        
        // When
        viewModel.changeCurrency(currency: .eur)
        
        // Then
        XCTAssertEqual(viewModel.fromCurrency, .eur)
        XCTAssertFalse(viewModel.isSheetPresented)
    }
    
    func test_filteredCurrencies_searchWorks() {
        // Given
        viewModel.searchedCurrency = "pln"
        
        // When
        let filtered = viewModel.filteredCurrencies
        
        // Then
        XCTAssertEqual(filtered, [.pln])
    }
    
    func test_filteredCurrencies_emptySearchReturnsAll() {
        // Given
        viewModel.searchedCurrency = ""
        
        // When
        let filtered = viewModel.filteredCurrencies
        
        // Then
        XCTAssertEqual(filtered.count, Currencies.allCases.count)
    }
}
