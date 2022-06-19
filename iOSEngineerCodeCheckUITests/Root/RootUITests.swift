//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class RootUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        /* In UI tests it’s important to set the initial state
            - such as interface orientation
            - required for your tests before they run.
            The setUp method is a good place to do this. */
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialScreen() throws {
        let app = XCUIApplication()
        app.launch()

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
            let tableCell = app.tableRows.firstMatch
            XCTAssertFalse(tableCell.exists)
        }
    }
}
