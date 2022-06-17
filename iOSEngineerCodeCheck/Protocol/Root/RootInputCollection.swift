//
//  RootInputCollection.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RootInputCollection: AnyObject {
    var repositories: [Repository] { get }
    func setRepositories(from items: [Repository])
    func tapTableViewCell(at index: Int)
    func tapSearchButton(with searchWord: String)
    func changedSearchText()
}
