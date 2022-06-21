//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    private var presenter: DetailInputCollection!

    @IBOutlet weak private var ownerAvatarImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var starsLabel: UILabel!
    @IBOutlet weak private var watchersLabel: UILabel!
    @IBOutlet weak private var forksLabel: UILabel!
    @IBOutlet weak private var issuesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let repository = presenter.repository

        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language)"
        starsLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        issuesLabel.text = "\(repository.openIssuesCount) open issues"

        setOwnerAvatarImage()
    }

    /// アバター画像をセットする
    private func setOwnerAvatarImage() {
        guard let avatarURL = URL(string: presenter.repository.owner.avatarURL)
        else { return }

        // 画像読み込み中はインジケーターを表示する
        ownerAvatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        ownerAvatarImageView.sd_setImage(with: avatarURL)
    }

    func inject(presenter: DetailInputCollection) {
        self.presenter = presenter
    }
}

// MARK: - DetailPresenterOutputCollection
extension DetailViewController: DetailOutputCollection {
}
