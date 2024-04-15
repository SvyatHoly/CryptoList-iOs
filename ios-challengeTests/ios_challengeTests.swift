//
//  ios_challengeTests.swift
//  ios-challengeTests
//
//  Created by Marc Flores on 10/4/24.
//

import XCTest
import Combine
@testable import ios_challenge

class MockTransactionsStateOwner: TransactionsStateOwner {
    let output = CurrentValueSubject<TransactionsStateOutput?, Never>(nil)
    let input = CurrentValueSubject<TransactionsStateAction?, Never>(nil)
}

final class ios_challengeTests: XCTestCase {
    var service: TransactionsService!
     var stateOwner: MockTransactionsStateOwner!
     var cancellables: Set<AnyCancellable>!
     
     override func setUp() {
         super.setUp()
         stateOwner = MockTransactionsStateOwner()
         service = TransactionsService(transactionsState: stateOwner)
         cancellables = []
     }
     
     override func tearDown() {
         service = nil
         stateOwner = nil
         cancellables = nil
         super.tearDown()
     }
     
     func testTotalPriceUsdCalculation() {
         let expect = expectation(description: "Total price USD updated")
         
         stateOwner.output
             .throttle(for: 0.1, scheduler: RunLoop.main, latest: true)
             .sink { output in
             if let output = output {
                 XCTAssertEqual(output.totalPriceUsd, 555.0, "Total price USD calculation is incorrect.")
                 expect.fulfill()
             }
         }.store(in: &cancellables)


         stateOwner.input.send(.purchase(amount: 10, currency: CryptoCurrency(id: "btc", rank: "nil", symbol: "BTC", name: "Bitcoin", supply: nil, maxSupply: nil, marketCapUsd: nil, volumeUsd24Hr: nil, priceUsd: 50.0, changePercent24Hr: nil, vwap24Hr: nil, explorer: .init(string: ""))))
         stateOwner.input.send(.purchase(amount: 1.1, currency: CryptoCurrency(id: "btc", rank: "nil", symbol: "BTC", name: "Bitcoin", supply: nil, maxSupply: nil, marketCapUsd: nil, volumeUsd24Hr: nil, priceUsd: 50.0, changePercent24Hr: nil, vwap24Hr: nil, explorer: .init(string: ""))))
         
         waitForExpectations(timeout: 1.0)
     }
 }
