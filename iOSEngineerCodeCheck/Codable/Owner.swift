//
//  Owner.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Owner: Codable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
