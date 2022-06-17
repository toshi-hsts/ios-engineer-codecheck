//
//  RootPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class RootPresenter {
    private weak var view: RootOutputCollection!
    private(set) var repositories: [Repository] = []
    private let gitHubAPIClient = GitHubAPIClient()

    init(view: RootOutputCollection) {
        self.view = view
    }
}

// MARK: - RootPresenterInputCollection
extension RootPresenter: RootInputCollection {
    /// リポジトリリスト更新
    func setRepositories(from items: [Repository]) {
        repositories = items
    }
    /// セルタップ時の挙動
    func tapTableViewCell(at index: Int) {
        let repository = repositories[index]
        view.moveToDeail(with: repository)
    }
    ///　検索バーでテキストの変更があった際の処理
    func changedSearchText() {
        gitHubAPIClient.cancelTask()
    }
    ///　検索ボタンが押された際の処理
    func tapSearchButton(with searchWord: URL) {
        gitHubAPIClient.fetchRepositories(with: searchWord) { [weak self] items in
            self?.setRepositories(from: items)
            self?.view.reloadTableView()
        } failureHandler: { errorDescription in
            print("errro:", errorDescription)
        }
    }
}
