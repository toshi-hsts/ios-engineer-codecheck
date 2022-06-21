//
//  DetailUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by ToshiPro01 on 2022/06/19.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest

class DetailUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        // 検索
        searchRepository()
        // セルタップ
        tapCell()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 初期画面が表示されていること
    func testInitialScreen() throws {
        let avaterImage = app.images.firstMatch
        let title = app.staticTexts["title"]
        let language = app.staticTexts["language"]
        let stars = app.staticTexts["stars"]
        let watchers = app.staticTexts["watchers"]
        let forks = app.staticTexts["forks"]
        let issues = app.staticTexts["issues"]
        let description = app.staticTexts["description"]
        let showMoreButton = app.buttons["showMoreButton"]

        XCTAssertTrue(avaterImage.exists)
        XCTAssertTrue(title.exists)
        XCTAssertTrue(language.exists)
        XCTAssertTrue(stars.exists)
        XCTAssertTrue(watchers.exists)
        XCTAssertTrue(forks.exists)
        XCTAssertTrue(issues.exists)
        XCTAssertTrue(description.exists)
        XCTAssertTrue(showMoreButton.exists)
    }

    // Root画面に遷移できること
    func testBackRootScreen() throws {
        let rootScreenTitle = "Root View Controller"
        app.buttons[rootScreenTitle].tap()
        XCTAssertTrue(app.navigationBars[rootScreenTitle].exists)
    }

    // 検索
    private func searchRepository() {
        let searchWord = "a"
        let searchBar = app.searchFields.firstMatch

        // 検索
        searchBar.tap()
        searchBar.typeText(searchWord)
        app.buttons["Search"].tap()

        // 通信待ち
        let loadingText = app.otherElements["loadingView"]
        let notExists = NSPredicate(format: "exists == false")

        expectation(for: notExists, evaluatedWith: loadingText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    // セルタップ
    private func tapCell() {
        let firstCell = app.cells.element(boundBy: 0)
        firstCell.tap()
    }
}
