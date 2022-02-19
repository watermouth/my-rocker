# 以下を真似しています。
# https://gihyo.jp/admin/serial/01/ubuntu-recipe/0531?page=2

FROM rocker/verse:4.1.2

## フォントのインストールと余計なデータの削除
RUN apt-get update \
  && apt-get install -y fonts-ipaexfont \
  && apt-get remove --purge -y $BUILDDEPS \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

## 標準のロケールとタイムゾーンの変更
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV TZ Asia/Tokyo
RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen ja_JP.UTF-8 \
  && update-locale LANG=ja_JP.UTF-8

## TeXパッケージのインストール
RUN tlmgr install \
  luatexja \
  luatexbase \
  ctablestack \
  adobemapping \
  ms \
  filehook

