//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class RootUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialScreen() throws {
        XCTContext.runActivity(named: "SearchBarが表示されていること") { _ in
            let searchBar = app.searchFields.firstMatch
            XCTAssertTrue(searchBar.exists)
        }

        XCTContext.runActivity(named: "SearchBarに初期文字列が入力されていること") { _ in
            let searchBar = app.searchFields.firstMatch
            XCTAssertEqual(searchBar.value as? String, "GitHubのリポジトリを検索できるよー")
        }

        XCTContext.runActivity(named: "TableViewが表示されていること") { _ in
            let tableView = app.tables.firstMatch
            XCTAssertTrue(tableView.exists)
        }

        XCTContext.runActivity(named: "TableViewにセルが表示されていないこと") { _ in
            let firstCell = app.cells.element(boundBy: 0)
            XCTAssertFalse(firstCell.exists)
        }
    }

    func testSearchRepository() throws {
        XCTContext.runActivity(named: "レポジトリ検索ができること") { _ in
            let searchWord = "aaa"
            let searchBar = app.searchFields.firstMatch

            searchBar.tap()
            searchBar.typeText(searchWord)
            app.buttons["Search"].tap()
            sleep(3)

            let firstCell = app.cells.element(boundBy: 0)

            XCTAssertTrue(firstCell.exists)
            XCTAssertEqual(searchBar.value as? String, searchWord)
        }
    }
}
