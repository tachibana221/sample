# システム開発入門
この資料は本システムの開発をすることになった人向けです。

## 1. 開発に必要な知識
本アプリケーションの開発に必要な知識とそれを学べるチュートリアルは大体以下の通り。多分progateで一通り学ぶのが手っ取り早い(月額1000円くらいかかるけど)。
雰囲気でわかることも多いと思うので別に全部のチュートリアルをやらなくてもいいけど最低でもRailsとGitは学んでおかないとしんどいと思う

- Ruby
  - https://prog-8.com/languages/ruby
- Rails
  - https://prog-8.com/languages/rails5
  - https://railstutorial.jp/
- Javascript
  - https://prog-8.com/languages/es6
- Jquery
  - https://prog-8.com/languages/jquery
- HTML & CSS
  - https://prog-8.com/languages/html
- Git
  - https://prog-8.com/languages/git
  - https://backlog.com/ja/git-tutorial
  - https://o2project.github.io/steins-git
- Docker
  - windowsでの環境構築がダルから使ってた。必須ではないので興味があれば適当にチュートリアル探してください

## 2.環境構築
多分これと同じディレクトリに環境構築の手順ドキュメントが入っていると思うからそれを参照してください

## 3.アプリケーションの構成
### ディレクトリ構成
railsのお作法に沿ってフォルダは分けているので、チュートリアルを一通りやればだいたい分かると思います(2019/7現在)。
javascriptファイルの配置がちょっとややこしいかもしれないので下で`lib/`、`vender/`ディレクトリと`config/initializers/assets.rb`を確認しておいてください。

参考サイト
- http://www5a.biglobe.ne.jp/~araibear/rails1_1.htm
- https://qiita.com/noraworld/items/07a2e9411eb74262a116

以下に重要な部分だけ抜粋して書いておきます。
- root
  - app : アプリケーションのメイン
    - controllers : 各コントローラーが入っている
    - models : 各モデルが入ってる
      - concerns : 複数のモデルで共通して使用するロジックを分離したもの
    - views : 各ビューが入ってる
    - validators : 絵文字の入力を弾くやつなどカスタムバリデーション（独自に定義したバリデーション）が入っている
  - config : 設定ファイルが入っている
    - initializers
      - assets.rb 使用したいjavascirptファイルをここで読みこむ。
    - locales : 翻訳ファイルが入っている
      - ja.yml : エラーメッセージ等の翻訳設定が記述されている
      - models : モデルの翻訳ファイルが入っている
        - ja.yml : モデル名やカラム名の翻訳設定が記述されている
    - application.rb : アプリケーション全体の設定が記述されている。あまり使うことはない
    - database.yml : データベースの設定が入っている。dockerを使う場合はここを書き換える必要がある（詳細はファイル内のコメント参照）
    - routes : ルーティングの設定が記述されている
  - db: データベース関連
    - migrate : マイグレーションファイル(DBの構成を変更するためのモノ)が入っている
    - schema.rb : 現在のデータベースのスキーマが書かれている。マイグレーションを実行すると自動で更新される
    - seeds.rb : データベースに初期値を入れたい場合にはここに記述する
  - documents : 解説資料などが入っている
  - lib : アプリケーションで使用するrubyファイル以外のスクリプトファイルが入っている(vendorとの違いはこっちは自分で書いたスクリプト)
    - assets/javascript
      - imageResize.js : 画像投稿時に画像のサイズを変更するスクリプト
      - measureDesignRSize.js : Design-Rで褥瘡のサイズを測定するスクリプト
      - setupPainer.js : 手書きコメントを入力するスクリプト
      - setupPaintViewer.js : 入力された手書きコメントを描画するためのスクリプト(setupPainer.jsから表示する処理だけを抜き出したもの)
  - public
    - uploads : 投稿した画像が保存される。このディレクトリは画像が投稿されると自動で作られる
  - vendor : 使用した外部ライブラリが入っている(libとの違いはこっちはDLしてきたライブラリ)
    - assets/javascript
      - konva.min.js : HTMLのcanvasを扱いやすくしてくれるライブラリ
  - .rubocop.yml : rubocopの設定ファイル
  - docker-compose & Dockerfile : Dockerの設定ファイル
  - Gemfile : 使用しているGem(Rubyのライブラリたち)の設定が入っている。新しいGemを使いたい場合はここに記入する