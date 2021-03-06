//
//  GitHubAPIClientCollection.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/18.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubAPIClientCollection: AnyObject {
    func fetchRepositories(with searchWord: String,
                           with page: Int,
                           successHandler: @escaping (_ items: [Repository], _ totalCount: Int) -> Void,
                           failureHandler: @escaping (_ apiError: APIError) -> Void)

    func cancelTask()
}
