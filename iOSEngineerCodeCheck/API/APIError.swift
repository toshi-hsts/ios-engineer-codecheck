//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum APIError {
    case invalidSearchWord
    case notStatusCode
    case noResponseData(statusCode: Int)
    case decodeFailure(statusCode: Int, catchedErrorText: String)
    case networkFailure(statusCode: Int, catchedErrorText: String)

    var description: String {
        switch self {
        case .invalidSearchWord:
            return "invalid search word"
        case .notStatusCode:
            return "status code is nil"
        case .noResponseData:
            return "response data is nil"
        case .decodeFailure( _, let catchedErrorText):
            return catchedErrorText
        case .networkFailure( _, let catchedErrorText):
            return catchedErrorText
        }
    }

    var aleertMessage: String {
        var message = "通信環境が良い場所で再度お試しください。解決しない場合は〇〇までご連絡お願いします。"

        switch self {
        case .networkFailure( let statusCode, _):
            if let alertMessage = StatusCodeCategory.convert(from: statusCode).alertMessage {
                message = alertMessage
            }
        case .invalidSearchWord:
            message = "検索キーワードが正しく入力されていない可能性があります。再入力をお願いします。"
        default: break
        }

        return message
    }
}
