//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var presenter: DetailInputCollection!

    @IBOutlet weak private var ownerAvatarImageView: UIImageView!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var starsNumberLabel: UILabel!
    @IBOutlet weak private var watchersNumberLabel: UILabel!
    @IBOutlet weak private var forksNumberLabel: UILabel!
    @IBOutlet weak private var issuesNumberLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let repository = presenter.repository
        navigationItem.title = repository.fullName

        languageLabel.text = "written in \(repository.language)"
        starsNumberLabel.text = String(repository.stargazersCount.addComma())
        watchersNumberLabel.text = String(repository.watchersCount.addComma())
        forksNumberLabel.text = String(repository.forksCount.addComma())
        issuesNumberLabel.text = String(repository.openIssuesCount.addComma())
        descriptionLabel.text = repository.description

        setOwnerAvatarImage()
    }

    /// アバター画像をセットする
    private func setOwnerAvatarImage() {
        let avatarURL = URL(string: presenter.repository.owner.avatarURL)
        ownerAvatarImageView.setImage(with: avatarURL)
    }

    func inject(presenter: DetailInputCollection) {
        self.presenter = presenter
    }

    @IBAction func tapShowMore(_ sender: Any) {
        guard let url = URL(string: presenter.repository.htmlURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - DetailPresenterOutputCollection
extension DetailViewController: DetailOutputCollection {
}
