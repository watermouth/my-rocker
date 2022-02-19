# my-rocker

## 概要

WSL2 Ubuntu 20.04 上での RStudio server環境構築用設定ファイル

## 主なファイル

- DockerfileForR
  - Dockerfileという名前にしていないのは個人的都合
- docker-compose.yml

## 使い方

```{bash}
# 開始
docker-compose up -d
# 終了
docker-compose down
```

## 留意点

### ライブラリのホスト側との共有

- renv利用を前提として、host側のcacheディレクトリをマウントしている.
  初回利用時, アクセス権限設定を行うことでrstudioユーザーがアクセスできるようになる.
  host側のUID, GIDが1000であり, コンテナ内の rstudio も UID, GIDが1000である想定で, 以下をhost側で実行すればよい.

  ```{bash}
  sudo chown 1000:1000 -R ~/.cache
  ```

- host側とlibraryフォルダを共有する. 上のrenvのcacheと同様の意味合いだが, もやはlibraryフォルダは不要かもしれない.

### RStudio global options のホスト側との共有

.configの置き場所がちがうようであれば適宜修正する. これでRStudio global optionsの設定がホスト側に残る.

```{yaml}
    # RStudio global option config
      - ~/.config:/home/rstudio/.config
```
