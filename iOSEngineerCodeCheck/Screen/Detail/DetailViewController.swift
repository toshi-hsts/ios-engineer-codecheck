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
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var descriptionTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let repository = presenter.repository

        titleLabel.text = repository.fullName
        languageLabel.text = repository.language
        starsLabel.text = String(repository.stargazersCount)
        watchersLabel.text = String(repository.watchersCount)
        forksLabel.text = String(repository.forksCount)
        issuesLabel.text = String(repository.openIssuesCount)
        descriptionLabel.text = repository.description

        if repository.description == nil {
            descriptionTitleLabel.isHidden = true
        }

        setOwnerAvatarImage()
    }

    /// アバター画像をセットする
    private func setOwnerAvatarImage() {
        let avatarURL = URL(string: presenter.repository.owner.avatarURL)

        // 画像読み込み中はインジケーターを表示する
        ownerAvatarImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        // 画像をセットする
        ownerAvatarImageView.sd_setImage(with: avatarURL) { ( _, error, _, _) in
            guard error != nil else { return }
            self.ownerAvatarImageView.image = UIImage(named: "loadingError")
        }
    }

    func inject(presenter: DetailInputCollection) {
        self.presenter = presenter
    }

    @IBAction func tapShowMore(_ sender: Any) {
        guard let url = URL(string: presenter.repository.htmlURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - DetailPresenterOutputCollection
extension DetailViewController: DetailOutputCollection {
}
