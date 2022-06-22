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
    @IBOutlet weak private var noResultView: NoResultView!
    @IBOutlet weak private var totalCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // 画面タッチ時の挙動
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボード閉じる
        view.endEditing(true)
    }

    private func setup() {
        totalCountLabel.text = ""
        navigationItem.backButtonTitle = "戻る"

        // ナビゲーションにリセットボタンをつける
        let resetBarButtonItem = UIBarButtonItem(title: "リセット",
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(tapResetBarButton(_:)))
        navigationItem.rightBarButtonItem = resetBarButtonItem

        // キーボードに閉じるボタンをつける
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let done = UIBarButtonItem(title: "閉じる",
                                   style: .done,
                                   target: self,
                                   action: #selector(tapCloseKeyboardButton))
        toolbar.items = [space, done]
        repositorySearchBar.inputAccessoryView = toolbar
    }

    func inject(_ presenter: RootInputCollection) {
        self.presenter = presenter
    }

    // 初期画面に戻る
    @objc func tapResetBarButton(_ sender: UIBarButtonItem) {
        totalCountLabel.text = ""
        repositorySearchBar.text = ""
        noResultView.isHidden = false
        presenter.reset()
    }

    // キーボード閉じる
    @objc func tapCloseKeyboardButton(_ sender: UIBarButtonItem) {
        repositorySearchBar.resignFirstResponder()
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

        searchBar.resignFirstResponder()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryTableViewCell
        let repository = presenter.repositories[indexPath.row]

        cell?.setup(title: repository.fullName, language: repository.language, avatarURL: repository.owner.avatarURL)

        return cell!
    }
}

// MARK: - UITableViewDelegate
extension RootViewController: UITableViewDelegate {
    // セルタップ時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

        showNoResultView()
    }
    /// 該当件数をセットする
    func setTotalCountLabel(with totalCount: String) {
        totalCountLabel.text = "該当：\(totalCount)件"
    }
    /// エラー時のアラートを表示する
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "エラー",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "再読み込み", style: .default, handler: { _ in
            self.presenter.reload()
        }))
        present(alert, animated: true)
    }

    /// 検索結果が0件のときはnoResultViewを表示する
    private func showNoResultView() {
        noResultView.isHidden = (presenter.repositories.isEmpty == false)
    }
}
