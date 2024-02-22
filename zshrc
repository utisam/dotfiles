#!/bin/zsh

##################################
# Linux / Mac で持ち運べる zshrc #
##################################

# セットアップ
#
# Mac:
# * brew install coreutils
# * PATH を通す
#
# 変更後はコンパイル
# zcompile ~/.zshrc
# 試しに現在のシェルに反映
# . ~/.zshrc

# ショートカットキー
#
# C-r		履歴から検索（後方検索）
# C-s		履歴から検索（前方検索）
# Esc-h		man 呼び出し
# Esc-q		現在入力中の文字列を退避
# C-a		先頭に移動
# C-e		末尾に移動
# C-k		カーソルから末尾まで削除
# C-w		単語単位で削除
# C-l		クリア
# M-up		上のディレクトリ
# M-left	戻る
# 何も入力せずに Enter  省略されたls (gitリポジトリなら git status)

# 計測用
#zmodload zsh/zprof && zprof

# OS判定用 (Linux/Darwin)
local UNAME=$(uname)

##############
## 基本設定 ##
##############

# command not foundの時にはインストール方法を提示
[[ -f "/etc/zsh_command_not_found" ]] && source /etc/zsh_command_not_found

# C-dでログアウトしない
#setopt ignore_eof
# zsh組み込みの関数を利用することでARG_MAXを回避する
# mvやrmが置き換えられてしまうのでお好みで
#zmodload zsh/files

# 4タブで表示
tabs -4

#####################
## cd カスタマイズ ##
#####################

# 自動cd(cdなしでおｋ
setopt auto_cd
# 移動履歴をプッシュ(cd -[Tab]
setopt auto_pushd
# 移動履歴をキューではなくスタックで番号付け(最近居た場所が上になる)
setopt pushd_minus
# 移動履歴の重複禁止
setopt PUSHD_IGNORE_DUPS
# 重複を優先して削除
setopt hist_expire_dups_first
# 移動先を検索するリスト。
cdpath=(~)

##############
## ヒストリ ##
##############

# 履歴の保存先
HISTFILE=${HOME}/.zsh_history
# 保存する履歴の数
SAVEHIST=1000000
# メモリに展開する履歴の数
HISTSIZE=$SAVEHIST
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups
# スペースで始まる場合はヒストリに追加しない
setopt hist_ignore_space
# すぐにヒストリファイルに追記する
setopt inc_append_history
# C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control
# 余計な空白を除去
setopt hist_reduce_blanks
# zshプロセス間でヒストリを共有する
setopt share_history

##############
## 環境変数 ##
##############

# 日本語utf-8
export LANG=ja_JP.UTF-8
# ライブラリパス
export LD_LIBRARY_PATH=${HOME}/local/lib:${LD_LIBRARY_PATH}

### 非端末プロセスならここで終了 ###
[ $#PROMPT -eq 0 -o $#TERM -eq 0 ] && return

################
## プロンプト ##
################

# プロンプト表示する度に変数展開・コマンド置換・算術演算を実行する
setopt prompt_subst
# PROMPT で % から始まる変換を有効にする
# %n	ユーザー名
# %M	コンピュータ名
# %c	カレントディレクトリ
setopt prompt_percent
# 色用の変数
#local BLACK=$'%{\e[1;30m%}'
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local PURPLE=$'%{\e[1;35m%}'
#local LIGHTBLUE=$'%{\e[1;36m%}'
#local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$'%{\e[1;m%}'
# 通常
PROMPT=$DEFAULT"%n@%M:"$BLUE"%c"$DEFAULT"$ "
# 複数行
PROMPT2="%_$ "
# サジェスト
export SPROMPT="%r is correct? [n,y,a,e]: "
# バージョン管理の情報の取得機能をロード
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s:%b'
zstyle ':vcs_info:*' actionformats '%s:%b:%a'
# 右プロンプト
# %*	時間
# %(x:true-text:false-text)	三項演算子
# %1v	psvar[1]
# %?	ステータスコード
RPROMPT=$DEFAULT"[$PURPLE%?%f|%1(V.%F{yellow}%1v%f|.)%2(V.%F{red}%2v%f|.)%F{green}%*%f$DEFAULT]"
# 複数行右プロンプト
#RPROMPT2
# プロンプト表示時の Hook
case "${TERM}" in
kterm*|xterm*)
	precmd() {
		# タイトル
		echo -ne "\033]0;$(basename ${PWD})[${PWD}]\007"
		# バージョン管理の情報の取得
		LANG=en_US.UTF-8 vcs_info
		psvar=()
		[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
		type -p kubectl >/dev/null 2>&1 && psvar[2]=$(command kubectl config current-context 2>/dev/null)
	}
	;;
esac
# コピペしやすいようにコマンド実行後は右プロンプトを消す
setopt transient_rprompt
# 対話式でも '#' をコメントとして解釈する
setopt interactivecomments
# 単語境界にならない記号
# /, ?, & は Path/URL の編集を重視して単語境界扱い
WORDCHARS='*_-.[]~;!#$%^(){}<>'

###########
## alias ##
###########

# ls
# ディレクトリには/, 色つき
alias ls="ls -FX --group-directories-first --color=auto"
# 隠しファイルも
alias la="ls -a"
# 詳細付き, ファイルサイズに接頭語
alias ll="ls -lh"
# 全部詳細
alias lla="ls -lha"
# tree
alias tree="tree -C"
# sl
alias -g sl="echo you are an idiot!"
alias -g SL="echo YOU ARE AN IDIOT!"
# cp
# 上書きを確認
alias cp="cp -i"
# rm
if type trash-put > /dev/null ; then
	alias rm="trash-put"
fi
# less に色をつける
if type src-hilite-lesspipe.sh 2>&1 > /dev/null; then
	export LESS='-R --tabs=4 --LONG-PROMPT'
	export LESSOPEN='| src-hilite-lesspipe.sh %s'
elif type pygmentize 2>&1 > /dev/null; then
	export LESSOPEN='| pygmentize -f terminal256 -O style=native -g %s'
	export LESS='-gj10 --no-init --RAW-CONTROL-CHARS'
fi
# grep
alias grep="grep --color=auto"
# ln
alias ln="ln -i -v"
# TUIモードで起動
#alias gdb="gdb -tui"
# 標準入力をコピー・ペースト
if [[ ${UNAME} = "Darwin" ]]; then
	alias toclip="pbcopy"
	alias fromclip="pbpaste"
elif [[ ${UNAME} = "Linux" ]]; then
	alias toclip="xsel -bi"
	alias fromclip="xsel -bo"
fi
# open (Mac は標準)
[[ ${UNAME} = "Linux" ]] && alias open="xdg-open"
# 打ち間違い対策
alias s="ls"
alias l="ls"
alias ks="echo '誰がカスじゃボケ'"
alias lsa=la

if type flutter 2>&1 > /dev/null ; then
	alias flutter="flutter --no-version-check"
fi

##########
## 関数 ##
##########

# 上へ移動する
# naoya さんのブログからコピペ
function cdup() {
	cd ..
	zle reset-prompt
}
# 戻る
function cdback() {
	popd
	zle reset-prompt
}
# 省略 ls
# yuyuchu3333 さんのブログからコピペしたものを改変
function ls_abbrev() {
	# COLUMNS=$COLUMNS: Evaluate width of console every time
	# -C: Force multi-column output
	# --color=always: Output color in subshell
	local ls_result=$(COLUMNS=$COLUMNS ls -C --color=always)
	if [[ $(wc -l <<< "$ls_result") -gt 10 ]]; then
		head -n 5 <<< "$ls_result"
		echo '...'
		tail -n 5 <<< "$ls_result"
		echo "$(command ls -1 -A | wc -l) files exist"
	else
		echo "$ls_result"
	fi
}
# SPROMPT で聞いてそれらに応じた exit code を返す
function ask_ynae {
	local prompt=${SPROMPT/\%r/$1}
	while true; do
		read -rsk \?"$prompt" ynae
		case $ynae in
		[Yy] ) return 0 ;;
		"" | [Nn] ) return 1 ;;
		[Aa] ) return 2 ;;
		[Ee] ) return 3 ;;
		esac
		echo -ne "\r"
	done
}
# git リポジトリ内なら exit 0
function in_git() {
	[[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]]
}
# ls & git status
# yuyuchu3333 さんのブログからコピペ
# bindkey と合わせてバッファが空のときの動作を設定
function do_enter() {
	if [[ -z "$BUFFER" ]]; then
		echo
		ls_abbrev
		if in_git; then
			echo -e "\e[0;33m--- git status ---\e[0m"
			\git status -s
			\git --no-pager stash list --pretty='format:%C(yellow)%gD %C(green)%cr %C(reset)%s'
			echo
		fi
		zle reset-prompt
	else
		zle accept-line
	fi
}
# git の alias では変えられない既存のコマンドの動作を変更す
function wrapped_git() {
	# switch に強制する
	#if [[ "$1" = "checkout" ]]; then
	#	echo -e "\033[1;41mUse switch or restore!\033[00m"
	# push のみなのに track してなかったら set-upstream をサジェストする
	if [[ "$*" = "push" ]] && in_git && ! (\git rev-parse --abbrev-ref @{upstream} >/dev/null 2>&1); then
		suggest="push -u origin $(\git rev-parse --abbrev-ref HEAD)"
		ask_ynae "git $suggest"
		exit_code=$?
		echo
		case $exit_code in
		"0" ) \git ${=suggest} ;;
		"1" ) \git $@ ;;
		"2" ) return 130 ;;
		"3" ) print -z "git $@" ;;
		esac
	else
		\git $@
	fi
}
alias git=wrapped_git

##################
## キーバインド ##
##################

# Emacs ベース
bindkey -e
# HOME キー
bindkey '^[[H' beginning-of-line
# END キー
bindkey '^[[F' end-of-line
# Deleteキー
bindkey '^[[3~' delete-char
# C-左右: 単語移動
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
# M-up: cdup
# M-left: popd
zle -N cdup
zle -N cdback
if [[ "${UNAME}" = "Darwin" ]]; then
	if [[ "${TERM_PROGRAM}" = "vscode" ]]; then
		bindkey '^[[1;3A' cdup
	else
		bindkey '^[^[[A' cdup
	fi
	bindkey '^[b' cdback
elif [[ ${UNAME} = "Linux" ]]; then
	bindkey '^[[1;3A' cdup
	bindkey '^[[1;3D' cdback
fi
# C-4: $() で囲む
bindkey -s '^\' ')^A $(^A'
# C-2: " で囲む
bindkey -s "^@" '"^A "^A'
# C-7: ' で囲む
bindkey -s "^[7" "'^A '^A"
# M-. で前のコマンドラインの末尾
#autoload -Uz smart-insert-last-word
#zle -N insert-last-word smart-insert-last-word
# C-x C-e でエディタで編集する
#autoload -Uz edit-command-line
#zle -N edit-command-line
#bindkey '^x^e' edit-command-line
# エンターキーで ls & git status
zle -N do_enter
bindkey '^m' do_enter

################
## 補完ルール ##
################

# 補完関数用フォルダ
for D in "/usr/share/zsh/vendor-completions" "/usr/local/share/zsh-completions" "$HOME/.compfunc"; do
	fpath=($D $fpath)
done

# コマンドラインオプションも補完
autoload -U compinit
compinit -u
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history _ignored
# 補完の時に大文字小文字を区別しない（ただし大文字を打った場合は小文字に変換しない）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完にキャッシュを使う
zstyle ':completion:*' use-cache true
# 矢印キーで補完選択
zstyle ':completion:*:default' menu select
# 補完関数をできるだけ過剰に
zstyle ':completion:*' verbose yes
# 補完候補にもlsと同じ色付き表示
eval $(dircolors) #色の設定を読み込み
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# 表示フォーマット
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
# プロセスの補完候補の設定
zstyle ':completion:*:*:*:*:processes' command "ps -u $(whoami) -o pid,user,comm -w -w"
# cd の補完候補の設定
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# cd は親ディレクトリからカレントディレクトリを表示させないようにする (cd ../<TAB>)
zstyle ':completion:*:cd:*' ignore-parents parent pwd
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# sudo時にはsudo用のパスも使う
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
# /etc/hosts と known_hosts を hostname の補完に使う
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
	"$_ssh_hosts[@]"
	"$_etc_hosts[@]"
	$(hostname)
	localhost
)
zstyle ':completion:*:hosts' hosts $hosts
# man はセクションごとに補完
zstyle ':completion:*:manuals' separate-sections true
# 先方予測・学習機能
#autoload predict-on
#predict-on
# タブキー連打で補完候補を順に表示
setopt auto_menu
# '='以降でも補完（--prefix=/usr など）
setopt magic_equal_subst
# 補完される前にオリジナルのコマンドまで展開してチェックする
setopt complete_aliases
# カーソル位置で補完
setopt complete_in_word
# 補完時にヒストリを自動的に展開
setopt hist_expand
# カッコの対応などを自動的に補完
setopt auto_param_keys
# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types
# 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
# 補完候補が複数ある時に一覧表示
setopt auto_list
# 補完候補が複数ある時にすぐに最初の候補を補完する
setopt menu_complete
#コマンド修正提示
#setopt correct		#通常
setopt correct_all	#ファイル名まで考慮
# 末尾の / を消去しない
setopt noautoremoveslash

# kubectl の補完を有効化（時間がかかるので遅延読み込み）
function kubectl() {
	if ! type __start_kubectl >/dev/null 2>&1; then
		source <(command kubectl completion zsh)
	fi
	command kubectl "$@"
}

# helm  の補完を有効化
#type helm > /dev/null && source <(helm completion zsh)

###################
## 開始時の hook ##
###################

# direnv
type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"
