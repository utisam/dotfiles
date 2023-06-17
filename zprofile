# デフォルトのエディタ
export EDITOR="vim"

########
## Go ##
########

# GOPATH
GOPATH="$HOME/go"
[[ -d $GOPATH ]] && export GOPATH

##########
## Java ##
##########

# JAVA_HOME
if [[ -d "/etc/alternatives/java_sdk" ]]; then
	export JAVA_HOME="/etc/alternatives/java_sdk"
fi

#########
## Zsh ##
#########

# '_' で始まる修正の提案はしない
export CORRECT_IGNORE='_*'
# '.' で始まるファイルの修正の提案はしない
export CORRECT_IGNORE_FILE='.*'

##########
## PATH ##
##########

[[ -x "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
[[ -x "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

CUSTOM_PATH=(
	# Homebrew opts
	"${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
	"${HOMEBREW_PREFIX}/opt/gettext/bin"
	"${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin"
	"${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin"
	"${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin"
	"${HOMEBREW_PREFIX}/opt/gzip/bin"
	"${HOMEBREW_PREFIX}/opt/llvm/bin"
	"${HOMEBREW_PREFIX}/opt/make/libexec/gnubin"
	# Dart
	"$HOME/.pub-cache/bin"
	# Flutter
	"/opt/flutter/bin"
	# Go
	"$GOPATH/bin"
	# Rust
	"$HOME/.cargo/bin"
	# Python
	"$HOME/.poetry/bin"
	# Android
	"$HOME/Library/Android/sdk/platform-tools"
	# Nordic
	"$HOME/.nrfutil/bin"
	# Home
	"$HOME/.local/bin"
	"$HOME/bin"
)
# npm bin が特殊なディレクトリになっている場合は必要
# type npm >/dev/null 2>&1 && CUSTOM_PATH+=$(npm bin -g 2>/dev/null)

for p in $CUSTOM_PATH; do
    [[ -d $p ]] && PATH="$p:$PATH"
done
export PATH
