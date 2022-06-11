//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var repositorySearchBar: UISearchBar!

    var repositories: [[String: Any]] = []
    var task: URLSessionTask?
    var searchWord: String!
    var searchRepositoryURL: String!
    var indexPathRow: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositorySearchBar.text = "GitHubのリポジトリを検索できるよー"
        repositorySearchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text else { return }
        guard searchBar.text?.isEmpty == false else { return }

        let searchRepositoryURL = "https://api.github.com/search/repositories?q=\(searchWord)"

        task = URLSession.shared.dataTask(with: URL(string: searchRepositoryURL)!) { (data, _, _) in
            let jsonObject = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            if let jsonObject = jsonObject, let items = jsonObject["items"] as? [[String: Any]] {
                self.repositories = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.rootViewController = self
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]

        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        indexPathRow = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
}
