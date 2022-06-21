//
//  GitHubAPIClientTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ToshiPro01 on 2022/06/19.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class GitHubAPIClientTests: XCTestCase {
    let gitHubAPIClient = GitHubAPIClient()
    var repositories: [Repository] = []
    let searchWord = "aaa"
    let page = 1
    var totalCount = 0

    /// リポジトリと該当件数を取得する
    func testFetchRepositories() throws {
        let expect = expectation(description: "fetchItems")
        gitHubAPIClient.fetchRepositories(with: searchWord, with: page) { [weak self] items, totalCount in
            self?.repositories = items
            self?.totalCount = totalCount
            expect.fulfill()
        } failureHandler: { _, _ in
        }

        wait(for: [expect], timeout: 10)
        XCTAssertTrue(self.repositories.count > 0)
        XCTAssertTrue(self.totalCount > 0)
    }

    /// リポジトリを取得を止める
    func testCancelTask() throws {
        let expect = expectation(description: "fetchItems")
        // fullfillが呼ばれなければ成功とする
        expect.isInverted = true

        gitHubAPIClient.fetchRepositories(with: searchWord, with: page) { [weak self] items, totalCount in
            self?.repositories = items
            self?.totalCount = totalCount
            expect.fulfill()
        } failureHandler: { _, _ in
        }

        gitHubAPIClient.cancelTask()

        wait(for: [expect], timeout: 5)
        XCTAssertTrue(self.repositories.isEmpty)
        XCTAssertTrue(self.totalCount == 0)
    }
}
