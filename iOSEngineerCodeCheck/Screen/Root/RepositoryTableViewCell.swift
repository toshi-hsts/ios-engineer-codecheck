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

    func setup(with title: String, with language: String) {
        titleLabel.text = title
        languageLabel.text = language
    }
}
