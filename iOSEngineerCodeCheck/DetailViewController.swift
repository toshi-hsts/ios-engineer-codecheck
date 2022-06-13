//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var rootViewController: RootViewController!

    @IBOutlet weak private var ownerAvatarImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var starsLabel: UILabel!
    @IBOutlet weak private var watchersLabel: UILabel!
    @IBOutlet weak private var forksLabel: UILabel!
    @IBOutlet weak private var issuesLabel: UILabel!

    private var repository: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        guard let indexPathRow = rootViewController.indexPathRow else { return }
        repository = rootViewController.repositories[indexPathRow]

        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"

        getImage()
    }

    /// アバター画像を取得する
    private func getImage() {
        guard let owner = repository["owner"] as? [String: Any],
              let avatarURL = owner["avatar_url"] as? String,
              let avatarURL = URL(string: avatarURL)
        else { return }

        titleLabel.text = repository["full_name"] as? String

        let task =  URLSession.shared.dataTask(with: avatarURL) { (data, _, _) in
            guard let data = data,
                  let avatarImage = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.ownerAvatarImageView.image = avatarImage
            }
        }
        task.resume()
    }
}
