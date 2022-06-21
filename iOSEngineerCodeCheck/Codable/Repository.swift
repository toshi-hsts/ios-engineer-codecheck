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
    let initialLanguage: String? // nilが返却される可能性があるためオプショナルとする(cf. https://docs.github.com/ja/rest/search)
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let htmlURL: String
    let description: String? // nilが返却される可能性があるためオプショナルとする(cf. https://docs.github.com/ja/rest/search)
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
        case htmlURL = "html_url"
        case description
        case owner
    }
}

extension Repository: Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        true
    }
}
