//
//  RootOutputCollection.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RootOutputCollection: AnyObject {
    func moveToDeail(with repository: Repository)
    func reloadTableView()
}
