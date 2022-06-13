//
//  GitHubAPIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GitHubAPIClient {

    private var task: URLSessionTask?

    /// リポジトリを取得する
    /// - Parameters:
    ///   - searchRepositoryURL: リポジトリ検索APIのURL
    ///   - successHandler: リポジトリ取得が成功した場合の処理
    ///   - failureHandler: リポジトリ取得が失敗した場合の処理
    /// - Returns: なし
    func fetchRepositories(with searchRepositoryURL: URL,
                           successHandler: @escaping (_ items: [[String: Any]]) -> Void,
                           failureHandler: @escaping () -> Void) {

        task = URLSession.shared.dataTask(with: searchRepositoryURL) { (data, _, _) in
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let items = jsonObject["items"] as? [[String: Any]]
            else {
                failureHandler()
                return
            }
            successHandler(items)
        }
        task?.resume()
    }

    ///  タスクを止める
    func cancelTask() {
        task?.cancel()
    }
}
