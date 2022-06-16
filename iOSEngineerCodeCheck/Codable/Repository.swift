//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let fullName: String
    // nilが返却される可能性があるためオプショナルとする(cf. https://docs.github.com/ja/rest/search)
    let initialLanguage: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner

    // initialLanguageがbnilのときは"unknown"とする
    var language: String {
        initialLanguage == nil ? "unknown" : initialLanguage!
    }

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case initialLanguage = "language"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
    }
}
