# GitHubリポジトリ検索くん
本アプリはGitHubのリポジトリを検索するシンプルなAppです。  
（株式会社ゆめみの技術課題です。cf. https://github.com/yumemi-inc/ios-engineer-codecheck　

<img src="https://user-images.githubusercontent.com/80573353/175236531-d8f69de9-bde7-454c-8f3e-96e23221300d.gif" width=200>

## 開発環境
Xcode 13.4.1.  
開発ターゲット　iOS 15.0

## 実行方法
### 必要ソフトとデバイス
- mac
- Xcode(13以上)
- iPhone simulater or iPhone実機（iOS15.0以上が導入されていること）

### 実行手順
1. プロジェクトを立ち上げる
```zsh
git clone git@github.com:toshi-hsts/ios-engineer-codecheck.git

cd/to/path

open ios-engineer-codecheck.xcodeproj
```
2. シミュレータor実機を起動　

## 仕様
- 任意のキーワードでリポジトリ検索できる
- 検索キーワードは日本語でも検索可能とする
- 検索後リセット（初期画面に戻る）を可能とする
- 検索後ローディング画面を表示する
- 検索後の画面でヒット件数を表示する
- リポジトリ取得においてエラー捕捉時はアラートを表示する
- スクロールすると自動読み込みする（無限スクロール）
- セルタップで詳細画面に遷移する
- 詳細画面からリポジトリページに遷移も可能する
- 画像取得時にローディングを表示する
- 画像取得失敗時は代替画像を表示する
- ダークモード対応

<p>
<img src="https://user-images.githubusercontent.com/80573353/175245167-d82721ee-2954-41bd-8e0e-789f370f9ae3.png" width=200>
  
<img src="https://user-images.githubusercontent.com/80573353/175244488-a9ae4a6c-0c35-4bc5-834d-e6ba0fdc5e73.png" width=200>

<img src="https://user-images.githubusercontent.com/80573353/175244723-468d55ec-a01e-4e40-8112-bf1224559b0c.png" width=200>
</p>
