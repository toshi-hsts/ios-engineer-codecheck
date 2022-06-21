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
                           successHandler: @escaping (_ items: [Repository], _ totalCount: Int) -> Void,
                           failureHandler: @escaping (_ apiError: APIError) -> Void) {

        guard let encodedSearchWord = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let searchRepositoryURL = URL(string:
                  "https://api.github.com/search/repositories?q=\(encodedSearchWord)&page=\(page)")
        else {
            let apiError = APIError.invalidSearchWord
            failureHandler(apiError)
            return
        }

        request = AF.request(searchRepositoryURL, method: .get).response { response in
            guard let statusCode = response.response?.statusCode else {
                let apiError = APIError.notStatusCode
                failureHandler(apiError)
                return
            }

            switch response.result {
            case .success(let data):
                guard let data = data else {
                    let apiError = APIError.noResponseData(statusCode: statusCode)
                    failureHandler(apiError)
                    return
                }

                do {
                    let searchResult  = try JSONDecoder().decode(SearchResult.self, from: data)
                    successHandler(searchResult.items, searchResult.totalCount)
                } catch let error {
                    let apiError = APIError.decodeFailure(statusCode: statusCode,
                                                          catchedErrorText: error.localizedDescription)
                    failureHandler(apiError)
                }
            case .failure(let error):
                let apiError = APIError.networkFailure(statusCode: statusCode,
                                                       catchedErrorText: error.localizedDescription)
                failureHandler(apiError)
            }
        }
        request?.resume()
    }

    ///  タスクを止める
    func cancelTask() {
        request?.cancel()
    }
}
