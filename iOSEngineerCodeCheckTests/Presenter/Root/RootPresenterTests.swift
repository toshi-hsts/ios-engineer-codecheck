//
//  iOSEngineerCodeCheckTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class RootPresenterTests: XCTestCase {
    let rootVCMock = RootVCMock()
    let gitHubAPIClientMock = APIClientMock()
    lazy var rootPresenter = RootPresenter(view: rootVCMock, apiClient: gitHubAPIClientMock)

    let firstTestRepository: Repository = .init(fullName: "test1", initialLanguage: "swift",
                                                stargazersCount: 10, watchersCount: 10, forksCount: 10,
                                                openIssuesCount: 10,
                                                owner: .init(avatarURL: "url1"))

    let secondTestRepository: Repository = .init(fullName: "test2", initialLanguage: "python",
                                                 stargazersCount: 20, watchersCount: 20, forksCount: 20,
                                                 openIssuesCount: 20,
                                                 owner: .init(avatarURL: "url2"))

    let thirdTestRepository: Repository = .init(fullName: "test3", initialLanguage: nil,
                                                stargazersCount: 30, watchersCount: 30, forksCount: 30,
                                                openIssuesCount: 30,
                                                owner: .init(avatarURL: "url3"))

    lazy var testRepositories: [Repository] = [firstTestRepository, secondTestRepository, thirdTestRepository]

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// リポジトリリスト更新
    func testSetRepositories() throws {
        rootPresenter.setRepositories(from: testRepositories)

        XCTAssertEqual(rootPresenter.repositories, testRepositories)
    }

    /// セルタップ時の挙動
    func testTapTableViewCell() {
        rootPresenter.setRepositories(from: testRepositories)
        rootPresenter.tapTableViewCell(at: 0)

        // モック関数が呼ばれていることを確認する
        XCTAssertEqual(rootVCMock.calledFunctionName, "moveToDeail(with:)")
    }

    ///　検索バーでテキストの変更があった際の処理
    func testChangedSearchText() {
        rootPresenter.changedSearchText()
        // モック関数が呼ばれていることを確認する
        XCTAssertEqual(gitHubAPIClientMock.calledFunctionName, "cancelTask()")
    }

    ///　検索ボタンが押された際の処理
    func testTapSearchButton() {
        rootPresenter.tapSearchButton(with: "test")

        // モック関数が呼ばれていることを確認する
        XCTAssertEqual(gitHubAPIClientMock.calledFunctionName, "fetchRepositories(with:successHandler:failureHandler:)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
