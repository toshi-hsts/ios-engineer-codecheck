//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var presenter: RootInputCollection!

    @IBOutlet weak private var repositorySearchBar: UISearchBar!
    @IBOutlet weak private var repositoryTableView: UITableView!
    @IBOutlet weak private var loadingView: LodingView!
    @IBOutlet weak var totalCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func inject(_ presenter: RootInputCollection) {
        self.presenter = presenter
    }
}

// MARK: - UISearchBarDelegate
extension RootViewController: UISearchBarDelegate {
    // 検索文字が変更されるたびに呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.changedSearchText()
    }

    // 検索ボタンがタップされるたびに呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text?.isEmpty == false,
              let searchWord = searchBar.text
        else { return }

        presenter.tapSearchButton(with: searchWord)
    }
}

// MARK: - UITableViewDataSource
extension RootViewController: UITableViewDataSource {
    // テーブルの1セクションあたりのセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }

    // セル設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repository = presenter.repositories[indexPath.row]

        cell.textLabel?.text = repository.fullName
//        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row

        return cell
    }
}

// MARK: - UITableViewDelegate
extension RootViewController: UITableViewDelegate {
    // セルタップ時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapTableViewCell(at: indexPath.row)
    }
}

// MARK: - UIScrollViewDelegate
extension RootViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // スクロールの現在位置
        let currentContentOffsetY = repositoryTableView.contentOffset.y
        // スクロール可能な最大位置
        let maxContentOffsetY = repositoryTableView.contentSize.height - repositoryTableView.frame.height
        // 現在の位置からスクロールの最下部までの距離
        let distance = maxContentOffsetY - currentContentOffsetY
        // 最下部から一定距離に近づいたら追加読み込みする
        if distance < 50 {
            presenter.approachTableViewBottom()
        }
    }
}

// MARK: - RootPresenterOutputCollection
extension RootViewController: RootOutputCollection {
    /// 詳細画面に移動する
    func moveToDeail(with repository: Repository) {
        Router.shared.showDetail(with: repository) { detailVC in
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    ///  テーブルビューを更新する
    func reloadTableView() {
        repositoryTableView.reloadData()
    }
    /// インジケーターを開始する
    func startAnimatingIndicator() {
        loadingView.startAnimatingIndicator()
        loadingView.isHidden = false
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    /// インジケータを停止する
    func stopAnimatingIndicator() {
        loadingView.stopAnimatingIndicator()
        loadingView.isHidden = true
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    /// 該当件数をセットする
    func setTotalCountLabel(with totalCount: Int) {
        totalCountLabel.text = "該当：\(totalCount)件"
    }
}
