//
//  UIImageView.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /// URLから画像をセットする
    /// - Parameters:
    ///   - url: 画像URL
    /// - Returns: なし
    func setImage(with url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                  let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
