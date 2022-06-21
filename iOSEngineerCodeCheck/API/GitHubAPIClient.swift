//
//  GitHubAPIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

class GitHubAPIClient: GitHubAPIClientCollection {

    private var request: Alamofire.Request?

    /// リポジトリを取得する
    /// - Parameters:
    ///   - searchWord: リポジトリ検索のキーワード
    ///   - page: 取得ページ
    ///   - successHandler: リポジトリ取得が成功した場合の処理
    ///   - failureHandler: リポジトリ取得が失敗した場合の処理
    /// - Returns: なし
    func fetchRepositories(with searchWord: String,
                           with page: Int,
                           successHandler: @escaping (_ items: [Repository]) -> Void,
                           failureHandler: @escaping (_ errorDescription: String) -> Void) {
        guard let searchRepositoryURL =
                    URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&page=\(page)")
        else { return }

        request = AF.request(searchRepositoryURL, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    failureHandler("response data is nil.")
                    return
                }

                do {
                    let searchResult  = try JSONDecoder().decode(SearchResult.self, from: data)
                    successHandler(searchResult.items)
                } catch let error {
                    failureHandler(error.localizedDescription)
                }
            case .failure(let error):
                failureHandler(error.localizedDescription)
            }
        }
        request?.resume()
    }

    ///  タスクを止める
    func cancelTask() {
        request?.cancel()
    }
}
