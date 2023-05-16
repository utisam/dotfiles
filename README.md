# dotfiles

設定ファイルです。

## zshrc

```sh
ln -s $PWD/zshrc ~/.zshrc

```

これまで大学や職場で CLI 初心者の方々に布教してきました。
方向キーで補完候補を選択できるあたりがウケが良いです。
布教のしやすさを優先しているため、あまり癖の強い設定はしていません。

Linux / Mac でも動くようにしていますが、
Mac の場合は coreutils だけ先にインストールしてください。

1 ファイルでなるべく依存を減らしています。
必須のセットアップを減らして「あればもっと便利に動く」ようにしています。
入れるだけでも良いですが、ファイルを読むとより使いこなせるようになります。

## zprofile

```sh
ln -s $PWD/zprofile ~/.zprofile
```

全マシンで共通の環境変数の設定を行っています。

マシン固有の環境変数は Linux なら `/etc/profile` もしくは `/etc/profile.d/*` を利用します。
Mac の場合は `/Library/LaunchAgents/*.plist` を launchctl load でロードするようにします。

## gitconfig

```ini
[user]
	email = youremail@example.com
	name = Your Name
[include]
	path = workspace/dotfiles/gitconfig
```

`include` を利用して取り込みます。

Mac の場合は `diff-highlight` のセットアップが必要です。

## vimrc

```sh
ln -s $PWD/vimrc ~/.vimrc
```

ターミナルから手軽にテキストを編集する用途で Vim を利用しています。

## IPython

```sh
ln -s $PWD/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -s $PWD/ipython_startup.ipy ~/.ipython/profile_default/startup/00-init.ipy
```
