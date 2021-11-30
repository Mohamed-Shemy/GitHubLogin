//
//  GitHubSearchViewControllerUITests.swift
//  GitHubLoginUITests
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import XCTest

class GitHubSearchViewControllerUITests: XCTestCase {
    
    // MARK: - Properties
    
    private var app: XCUIApplication!
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        continueAfterFailure = true
    }
    
    // MARK: - Test Cases
    
    func testSearchWithSubmitButton() throws {
        app.launch()
        searchWithSubmit(for: "mohamed")
        let table = app.tables.element(boundBy: 0)
        let count = table.cells.count
        XCTAssert(count == 18, "page 2 not loaded")
    }
    
    func testSearchWithReturnKey() {
        app.launch()
        searchWithReturnKey(for: "mohamed")
        let table = app.tables.element(boundBy: 0)
        let count = table.cells.count
        XCTAssert(count == 18, "page 2 not loaded")
    }
    
    func testGetPageThree() {
        app.launch()
        searchWithReturnKey(for: "mohamed")
        let table = app.tables.element(boundBy: 0)
        table.swipeUp()
        table.swipeUp()
        table.swipeUp()
        let count = table.cells.count
        XCTAssert(count == 27, "page 3 not loaded")
    }
    
    func testEmptySearchKey() {
        app.launch()
        searchWithReturnKey(for: "")
        let table = app.tables.element(boundBy: 0)
        let count = table.cells.count
        XCTAssert(count == 0, "page 3 not loaded")
    }
    
    // MARK: - Helper Methods
    
    private func searchWithSubmit(for key: String) {
        search(for: key)
        app.buttons["Submit"].tap()
    }
    
    private func searchWithReturnKey(for key: String) {
        search(for: key)
        app.textFields.element.typeText(XCUIKeyboardKey.return.rawValue)
    }
    
    private func search(for key: String) {
        app.textFields.element.tap()
        app.textFields.element.typeText(key)
    }
}
