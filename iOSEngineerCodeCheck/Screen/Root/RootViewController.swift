//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    @IBOutlet weak private var repositorySearchBar: UISearchBar!

    private let gitHubAPIClient = GitHubAPIClient()
    var repositories: [Repository] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            if let detailViewController = segue.destination as? DetailViewController,
               let repositorySelected = sender as? Repository {
                detailViewController.repository = repositorySelected
            }
        }
    }

    private func setup() {
        repositorySearchBar.text = "GitHubのリポジトリを検索できるよー"
        repositorySearchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension RootViewController: UISearchBarDelegate {
    // フォーカスが当たるたびに呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    // 検索文字が変更されるたびに呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        gitHubAPIClient.cancelTask()
    }

    // 検索ボタンがタップされるたびに呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text?.isEmpty == false,
              let searchWord = searchBar.text,
              let searchRepositoryURL = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        else { return }

        gitHubAPIClient.fetchRepositories(with: searchRepositoryURL) { [weak self] items in
            self?.repositories = items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } failureHandler: { errorDescription in
            print("errro:", errorDescription)
        }
    }
}

// MARK: - UITableViewDataSource
extension RootViewController {
    // テーブルの1セクションあたりのセル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    // セル設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]

        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row

        return cell
    }
}

// MARK: - UITableViewDelegate
extension RootViewController {
    // セルタップ時に呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositorySelected = repositories[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: repositorySelected)
    }
}