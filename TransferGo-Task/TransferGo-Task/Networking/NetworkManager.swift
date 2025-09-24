//
//  NetworkManager.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import Foundation

protocol NetworkProtocol {
    func fetchValueFromAPI(from: Currencies, amount: Double, to: Currencies) async -> (amount: Double?, rate: Double?)
}


final class NetworkManager: NetworkProtocol {
    private let baseURL = "https://my.transfergo.com/api/fx-rates"
    
    func fetchValueFromAPI(from: Currencies, amount: Double, to: Currencies) async -> (amount: Double?, rate: Double?) {
        do {
            guard var baseComponent = URLComponents(string: baseURL) else {
                print("Invalid base component")
                return (nil, nil)
            }
            baseComponent.queryItems = [
                URLQueryItem(name: "from", value: from.rawValue.uppercased()),
                URLQueryItem(name: "to", value: to.rawValue.uppercased()),
                URLQueryItem(name: "amount", value: String(format: "%.2f", amount))
            ]
            
            guard let url = baseComponent.url else {
                print("Invalid URL")
                return (nil, nil)
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return (nil, nil)
            }
            
            let fxResponse = try JSONDecoder().decode(FXRateModel.self, from: data)
            return (fxResponse.toAmount, fxResponse.rate)
        } catch {
            print("Error fetching FX rate:", error)
            return (nil, nil)
        }
    }
}

final class MockNetworkManager: NetworkProtocol {
    var mockRates: [String: Double] = [
        "PLN_UAH": 7.50,
        "EUR_UAH": 48.56,
        "GBP_UAH": 56.12
    ]
    
    func fetchValueFromAPI(from: Currencies, amount: Double, to: Currencies) async -> (amount: Double?, rate: Double?) {
        let key = "\(from.rawValue.uppercased())_\(to.rawValue.uppercased())"
        let rate = mockRates[key] ?? 0
        
        let convertedAmount = rate * amount
        print("[MockNetworkManager] \(amount) \(from.rawValue.uppercased()) -> \(convertedAmount) \(to.rawValue.uppercased())")
        return (convertedAmount, rate)
    }
}

