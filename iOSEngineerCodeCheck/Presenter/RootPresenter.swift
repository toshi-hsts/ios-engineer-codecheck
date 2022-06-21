//
//  RootPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class RootPresenter {
    enum LoadState {
        case standby
        case loading
        case none
    }

    private weak var view: RootOutputCollection!
    private(set) var repositories: [Repository] = []
    private let gitHubAPIClient: GitHubAPIClientCollection!
    private var loadState: LoadState = .none
    private var searchedWord = ""
    private var page = 0

    init(view: RootOutputCollection, apiClient: GitHubAPIClientCollection) {
        self.view = view
        self.gitHubAPIClient = apiClient
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
    func tapSearchButton(with searchWord: String) {
        view.startAnimatingIndicator()
        loadState = .loading
        searchedWord = searchWord
        page = 1
        repositories = []

        fetchRepositories()
    }

    /// TableViewが下部に近づいた際の処理
    func approachTableViewBottom() {
        guard loadState == .standby else { return }

        view.startAnimatingIndicator()
        loadState = .loading
        page += 1

        fetchRepositories()
    }
    /// 再読み込み
    func reload() {
        // 検索ボタン押下時と同じ処理を試す
        tapSearchButton(with: searchedWord)
    }

    /// リポジトリ取得
    private func fetchRepositories() {
        gitHubAPIClient.fetchRepositories(with: searchedWord, with: page) { [weak self] items, totalCount in
            self?.repositories += items
            self?.loadState = .standby
            self?.setTotalCount(with: totalCount)
            self?.view.reloadTableView()
            self?.view.stopAnimatingIndicator()
        } failureHandler: { [weak self] errorDescription, statusCode in
            self?.loadState = .standby
            self?.handleStatusCode(with: statusCode)
            self?.view.stopAnimatingIndicator()
            self?.view.reloadTableView()
            print("errro:", errorDescription)
        }
    }
    // 該当件数をセット
    private func setTotalCount(with totalCount: Int) {
        // 1ページ目の時だけ該当件数を更新する
        if page == 1 {
            let convertedTotalCount = totalCount.addComma()
            view.setTotalCountLabel(with: convertedTotalCount)
        }
    }

    private func handleStatusCode(with statusCode: Int?) {
        let convertedStatusCode: Int = statusCode ?? 0 // nilは0としてハンドリングする
        let statusCodeCategory = StatusCodeCategory.convert(from: convertedStatusCode)
        var message = ""

        switch statusCodeCategory {
        case .serverError:
            message = "メンテナンス中、もしくは障害が発生しています。ご迷惑おかけしますが\nしばらくお待ちください。"
        default:
            message = "通信環境が良い場所で再度お試しください。解決しない場合は〇〇までご連絡お願いします。"
        }

        view.showErrorAlert(with: message)
    }
}
