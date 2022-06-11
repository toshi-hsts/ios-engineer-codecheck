//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ownerAvatarImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var rootViewController: RootViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repository = rootViewController.repositories[rootViewController.indexPathRow]

        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()

    }

    func getImage() {

        let repository = rootViewController.repositories[rootViewController.indexPathRow]

        titleLabel.text = repository["full_name"] as? String

        if let owner = repository["owner"] as? [String: Any] {
            if let avatarURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: avatarURL)!) { (data, _, _) in
                    let avatarImage = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ownerAvatarImageVIew.image = avatarImage
                    }
                }.resume()
            }
        }
    }
}
