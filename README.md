# if_then_method

if then ルールの考え方に沿ってルールを登録し、一覧表示するアプリです。  
習慣化や目標達成をサポートします。

## AppStore

[アプリの App Store](https://apps.apple.com/jp/app/if-then-%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89/id1547511045)

## if then ルールとは？

「もしこうなったら、こうする」という実行計画です。習慣化しやすく目標達成率の高い手法です。  
この[記事](https://news.mynavi.jp/article/20200908-1257427/)を読むことで、概要を掴むことができると思います。

### 参考文献(if then について)

[論文](https://cancercontrol.cancer.gov/sites/default/files/2020-06/goal_intent_attain.pdf)が一番正確だと思います。

## 作成した目的

自分で if then ルールを実践していた当初はテキストエディタや EXCEL で管理していました。  
しかし、レイアウトが統一しづらかったり、ルールの達成状況がわかりづらかったりしたので、アプリ化してみました。  
また、Flutter の学習をしていたからという理由もあります。

## 使用技術

- Flutter 1.23.0-18.1.pre
- Dart 2.11.0
- Firebase
  - Firestore
  - Auth

## 機能一覧

- ログイン機能（Apple、Google）
- if then ルールの CRUD
- 各ルールの実行 Score のカウント機能
- リストの並び替え（ドラック＆ドロップ）

## 【GIF】アプリの動作イメージ

![README_画面イメージ](https://user-images.githubusercontent.com/38233307/130701340-b28867f9-e640-4a9a-ba7b-8b6a54ca373e.gif)
