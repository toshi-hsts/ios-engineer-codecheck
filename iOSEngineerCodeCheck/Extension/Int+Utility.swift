//
//  Int+Utility.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/21.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension Int {
    /// 3桁区切りのコンマを付与する cf. 123,456,789
    func addComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let number = "\(formatter.string(from: NSNumber(value: self)) ?? "")"

        return number
    }
}
