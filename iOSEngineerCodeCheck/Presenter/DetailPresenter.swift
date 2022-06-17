//
//  DetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/18.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class DetailPresenter {
    private weak var view: DetailOutputCollection!
    private(set) var repository: Repository

    init(view: DetailOutputCollection, repository: Repository) {
        self.view = view
        self.repository = repository
    }
}

// MARK: - DetailPresenterInputCollection
extension DetailPresenter: DetailInputCollection {
}
