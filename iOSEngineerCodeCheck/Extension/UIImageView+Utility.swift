//
//  UIImageView+Utility.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    /// 画像セット、ローディング、失敗時の画像表示をまとめて処理する
    func setImage(with url: URL?) {
        // 画像読み込み中はインジケーターを表示する
        self.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        // 画像をセットする
        self.sd_setImage(with: url) { ( _, error, _, _) in
            guard error != nil else { return }
            self.image = UIImage(named: "loadingError")
        }
    }
}
