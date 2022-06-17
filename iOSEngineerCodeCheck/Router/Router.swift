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
        showHandler(rootNC)
    }
}
