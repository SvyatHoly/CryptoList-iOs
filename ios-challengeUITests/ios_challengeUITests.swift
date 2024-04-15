//
//  ios_challengeUITests.swift
//  ios-challengeUITests
//
//  Created by Marc Flores on 10/4/24.
//

import XCTest

class CryptoListViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testCryptoListViewDisplaysItems() {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.navigationBars["Cryptocurrencies"].exists, "The navigation bar should be displayed with the title 'Cryptocurrencies'.")

        let lists = app.collectionViews
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: lists.firstMatch, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertGreaterThan(lists.firstMatch.cells.count, 0, "There should be at least one item in the list.")
        
        // Tap on the first item
        let firstCell = lists.firstMatch.cells.firstMatch
        if firstCell.exists {
            firstCell.tap()
            XCTAssertTrue(app.staticTexts["Purchase"].exists, "Should navigate to the Purchase View.")
        }
    }
}
