//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var repository: [String: Any] = [:]

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
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        titleLabel.text = repository["full_name"] as? String ?? ""

        setOwnerAvatarImage()
    }

    /// アバター画像をセットする
    private func setOwnerAvatarImage() {
        guard let owner = repository["owner"] as? [String: Any],
              let avatarURL = owner["avatar_url"] as? String,
              let avatarURL = URL(string: avatarURL)
        else { return }

        ownerAvatarImageView.setImage(with: avatarURL)
    }
}
