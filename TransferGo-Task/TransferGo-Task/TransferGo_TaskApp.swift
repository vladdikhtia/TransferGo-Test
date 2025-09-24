//
//  TransferGo_TaskApp.swift
//  TransferGo-Task
//
//  Created by Vladyslav Dikhtiaruk on 23/09/2025.
//

import SwiftUI

@main
struct TransferGo_TaskApp: App {
    let networkManager = NetworkManager()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ConverterView(networkManager: networkManager)

            }
        }
    }
}
