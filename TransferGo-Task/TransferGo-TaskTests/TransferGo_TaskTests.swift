//
//  TransferGo_TaskTests.swift
//  TransferGo-TaskTests
//
//  Created by Vladyslav Dikhtiaruk on 24/09/2025.
//

import XCTest

final class TransferGoInterviewTasksTests: XCTestCase {

    /// Precondition -> Disable Predictive code completion
    /// 1. Open Xcode -> Settings
    /// 2. Click "Text Editing"
    /// 3. Click "Editing"
    /// 3. Unclick "Predictive code completion" checkbox

    // Task 0: Create new branch "feature/interview-tasks"
    // Switch to that branch and commit each task on this branch.
    
    // Task 1: **Dictionary values to Array**
    func testDictionaryToSortedArray() throws {
        let scores = ["Alice": 90, "Bob": 75, "Charlie": 85]
        let myValues = scores.values.sorted {
            $0 > $1
        }
        
        XCTAssertEqual(Array(myValues), [90, 85, 75])
    }

    //    Task 2: **Protocol ConformanceDescription**
    //
    //    1. Create a protocol `Vehicle` with a property `name` and a function `start()`.
    //    2. Create two structs `Car` and `Bicycle` that conform to `Vehicle`.
    //    3. `Car`’s `start()` should print `"Car {name} engine started"`.
    //    4. `Bicycle`’s `start()` should print `"Bicycle {name} ready to ride"`.

    protocol Vehicle {
        var name: String { get }
        func start()
    }
    
    struct Car: Vehicle {
        var name: String
        
        func start() {
            print("Car \(name) engine started")
        }
    }
    struct Bicycle: Vehicle {
        var name: String
        func start() {
            print("Bicycle \(name) ready to ride")
        }
    }
    
    func testCarAndBicicle() throws {
        // Just example usage, no Units.
    }
    
    // Task 3: Merge branch that you were on to main branch.
    // Bonus: Explain what happens if there is a merge conflict and how you would resolve it.

}
