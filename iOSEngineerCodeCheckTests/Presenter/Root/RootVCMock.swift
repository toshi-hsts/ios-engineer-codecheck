//
//  RootVCMock.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ToshiPro01 on 2022/06/19.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

class RootVCMock: RootOutputCollection {
    var calledFunctionName = ""

    func moveToDeail(with repository: Repository) {
        calledFunctionName = #function
    }

    func reloadTableView() {
    }

    func startAnimatingIndicator() {
        calledFunctionName = #function
    }

    func stopAnimatingIndicator() {
    }

    func setTotalCountLabel(with: String) {
    }

    func showErrorAlert(with statusCode: Int) {
    }
}
