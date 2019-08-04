# 看護システム

## 環境構築までの全体の手順

1. Hyper-Vを有効にする
2. Docker Desktop for windows をインストールし、Docker を起動
3. コンテナの作成、起動

## Hyper-Vの有効化

dockerを扱うために必要なCPUの設定を行います。

#### 方法1

　windowsボタンを右クリックし、windows powershel（管理者をクリック）を選択し

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
```

を入力しenterを押す。

その後PCを再起動する。

#### 方法2

1. windowsボタンを右クリックし、その後""アプリと機能"をクリック
2. "プログラムと機能"をクリック
3. "windowsの機能の有効化または無効化"をクリック
4. "Hyper-V"のチェックを外す
5. "OK"をクリック
6. PCの再起動を行う
7. 

## Docker for Desktopのインストール

　次のurl"https://docs.docker.com/docker-for-windows/install/"にアクセスしてもらい、アクセスしたページ

の [**download.docker.com**](https://download.docker.com/win/stable/Docker for Windows Installer.exe).をクリックするとインストーラがダウンロードされるのでそのまま実行。

インストーラーの実行の際、設定はいじらずにそのまま次へ進んでいきインストールを完了してください。

インストールに成功したら、作成されたDocker for windowsをダブルクリックすることでDockerを起動できます。

## コンテナの作成および起動

　Nurse_systemのフォルダ内に存在するserver-start.batをダブルクリックで実行、その後

"http://localhost:3000/"にアクセスすると看護システムのtop画面が開く。

外部のデバイスからアクセスする際にはlocalhostの部分をdockerをインストールしたPCのipアドレスに変更してください。

　ipアドレスを調べるには、コマンドプロンプト（デスクトップ左下のwindowsボタンを右クリックして出てきたメニューから起動）にipconfigとコマンドを入力することで調べられます。localhostと置き換えるアドレスはIPv4と書かれているものです。

以上で環境構築は完了です。



## 初回以降の起動

　Docker for windowsを起動後、server-start.batをダブルクリックで実行することで、ブラウザからアクセス可能な状態になる。