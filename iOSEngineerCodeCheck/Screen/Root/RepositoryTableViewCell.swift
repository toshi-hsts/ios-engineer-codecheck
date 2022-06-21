//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var avatarImageView: UIImageView!

    func setup(title: String, language: String, avatarURL: String) {
        let url = URL(string: avatarURL)

        titleLabel.text = title
        languageLabel.text = language

        // 画像読み込み中はインジケーターを表示する
        avatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        // 画像をセットする
        avatarImageView.sd_setImage(with: url) { ( _, error, _, _) in
            guard error != nil else { return }
            self.avatarImageView.image = UIImage(named: "loadingError")
        }
    }
}
