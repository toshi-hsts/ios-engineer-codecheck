//
//  SearchResult.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let totalCount: Int
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
