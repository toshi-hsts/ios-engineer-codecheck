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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialScreen() throws {
        XCTContext.runActivity(named: "初期画面が表示されていること") { _ in
            // 検索
            searchRepository()

            // セルタップ
            let firstCell = app.cells.element(boundBy: 0)
            firstCell.tap()

            // 初期画面表示の確認
            let avaterImage = app.images.firstMatch
            let title = app.staticTexts["title"]
            let language = app.staticTexts["language"]
            let stars = app.staticTexts["stars"]
            let watchers = app.staticTexts["watchers"]
            let forks = app.staticTexts["forks"]
            let issues = app.staticTexts["issues"]

            XCTAssertTrue(avaterImage.exists)
            XCTAssertTrue(title.exists)
            XCTAssertTrue(language.exists)
            XCTAssertTrue(stars.exists)
            XCTAssertTrue(watchers.exists)
            XCTAssertTrue(forks.exists)
            XCTAssertTrue(issues.exists)
        }
    }

    func testBackRootScreen() throws {
        XCTContext.runActivity(named: "Root画面に遷移できること") { _ in
            // 検索
            searchRepository()

            // セルタップ
            let firstCell = app.cells.element(boundBy: 0)
            firstCell.tap()

            // root画面に戻るかの確認
            let rootScreenTitle = "Root View Controller"
            app.buttons[rootScreenTitle].tap()
            XCTAssertTrue(app.navigationBars[rootScreenTitle].exists)
        }
    }

    private func searchRepository() {
        let searchWord = "aaa"
        let searchBar = app.searchFields.firstMatch

        // 検索
        searchBar.tap()
        searchBar.typeText(searchWord)
        app.buttons["Search"].tap()
        sleep(3)
    }
}
