//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by ToshiPro01 on 2022/06/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var avatarImageView: UIImageView!

    func setup(title: String, language: String, avatarURL: String) {
        let url = URL(string: avatarURL)

        titleLabel.text = title
        languageLabel.text = language
        avatarImageView.setImage(with: url)
    }
}
