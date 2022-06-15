//
//  GitHubAPIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

class GitHubAPIClient {

    private var request: Alamofire.Request?

    /// リポジトリを取得する
    /// - Parameters:
    ///   - searchRepositoryURL: リポジトリ検索APIのURL
    ///   - successHandler: リポジトリ取得が成功した場合の処理
    ///   - failureHandler: リポジトリ取得が失敗した場合の処理
    /// - Returns: なし
    func fetchRepositories(with searchRepositoryURL: URL,
                           successHandler: @escaping (_ items: [[String: Any]]) -> Void,
                           failureHandler: @escaping (_ errorDescription: String) -> Void) {

        request = AF.request(searchRepositoryURL, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    failureHandler("response data is nil.")
                    return
                }

                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let jsonObject = jsonObject,
                       let items = jsonObject["items"] as? [[String: Any]] {
                        successHandler(items)
                    }
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
