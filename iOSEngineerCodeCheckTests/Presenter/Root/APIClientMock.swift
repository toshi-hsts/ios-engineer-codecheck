//
//  APIClientMock.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ToshiPro01 on 2022/06/19.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

class APIClientMock: GitHubAPIClientCollection {

    var calledFunctionName = ""

    func fetchRepositories(with searchWord: String,
                           successHandler: @escaping ([Repository]) -> Void,
                           failureHandler: @escaping (String) -> Void) {
    }

    func cancelTask() {
        calledFunctionName = #function
    }
}
