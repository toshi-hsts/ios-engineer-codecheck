//
//  Router.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

import UIKit

final class Router {

    public static let shared = Router()

    /// root画面を表示する
    func showRoot(showHandler: (_ rootNC: UINavigationController) -> Void) {
        guard let rootVC = UIStoryboard(name: "Root", bundle: nil)
            .instantiateViewController(withIdentifier: "rootVC") as? RootViewController else { return }

        let rootNC = UINavigationController(rootViewController: rootVC)
        let githubAPIClient = GitHubAPIClient()
        let rootPresenter = RootPresenter(view: rootVC, apiClient: githubAPIClient)

        rootVC.inject(rootPresenter)
        showHandler(rootNC)
    }

    /// detail画面を表示する
    func showDetail(with repository: Repository,
                    showHandler: (_ detailVC: DetailViewController) -> Void) {
        guard let detailVC = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return}

        let detailPresenter = DetailPresenter(view: detailVC, repository: repository)
        detailVC.inject(presenter: detailPresenter)

        showHandler(detailVC)
    }
}
