//
//  StatusCodeCategory.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum StatusCodeCategory {
    case serverError
    case clientError
    case other
    case none

    static func convert(from statusCode: Int) -> StatusCodeCategory {
        switch statusCode {
        case 500...599:
            return .serverError
        case 400...499:
            return .clientError
        case 0:
            return .none
        default:
            return .other
        }
    }
}
