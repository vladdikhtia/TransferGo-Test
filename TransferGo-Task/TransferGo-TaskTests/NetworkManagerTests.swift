//
//  NetworkManagerTests.swift
//  TransferGo-TaskTests
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import XCTest
@testable import TransferGo_Task

final class NetworkManagerTests: XCTestCase {
    
    var mockNetwork: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetwork = MockNetworkManager()
    }
    
    override func tearDownWithError() throws {
        mockNetwork = nil
    }
    
    func test_fetchValueFromAPI_validConversion_returnsCorrectAmountAndRate() async throws {
        // Given
        let fromCurrency: Currencies = .pln
        let toCurrency: Currencies = .uah
        let amount: Double = 100
        
        // When
        let result = await mockNetwork.fetchValueFromAPI(from: fromCurrency, amount: amount, to: toCurrency)
        
        // Then
        XCTAssertEqual(result.rate, 7.50)
        XCTAssertEqual(result.amount, 750.0)
    }
    
    func test_fetchValueFromAPI_unknownConversion_returnsZero() async throws {
        // Given
        let fromCurrency: Currencies = .uah
        let toCurrency: Currencies = .gbp
        let amount: Double = 100
        
        // When
        let result = await mockNetwork.fetchValueFromAPI(from: fromCurrency, amount: amount, to: toCurrency)
        
        // Then
        XCTAssertEqual(result.rate, 0)
        XCTAssertEqual(result.amount, 0)
    }
    
    func test_fetchValueFromAPI_zeroAmount_returnsZeroAmount() async throws {
        // Given
        let result = await mockNetwork.fetchValueFromAPI(from: .pln, amount: 0, to: .uah)
        
        // Then
        XCTAssertEqual(result.amount, 0)
        XCTAssertEqual(result.rate, 7.50)
    }
    
    func test_fetchValueFromAPI_negativeAmount_returnsNegativeAmount() async throws {
        // Given
        let result = await mockNetwork.fetchValueFromAPI(from: .pln, amount: -100, to: .uah)
        
        // Then
        XCTAssertEqual(result.amount, -750.0)
        XCTAssertEqual(result.rate, 7.50)
    }
}
