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
