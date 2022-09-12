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

local UNAME=$(uname)
local ARCH=$(uname -m)

if [[ "${UNAME}" = "Darwin" && "${ARCH}" = "x86_64" ]]; then
	export BREW_HOME="/usr/local"
else
	export BREW_HOME="/opt/homebrew"
fi

CUSTOM_PATH=(
	# Homebrew opts
	"${BREW_HOME}/opt/coreutils/libexec/gnubin"
	"${BREW_HOME}/opt/gettext/bin"
	"${BREW_HOME}/opt/gnu-sed/libexec/gnubin"
	"${BREW_HOME}/opt/grep/libexec/gnubin"
	"${BREW_HOME}/opt/llvm/bin"
	"${BREW_HOME}/opt/make/libexec/gnubin"
	"${BREW_HOME}/opt/gnu-tar/libexec/gnubin"
	# nRF52 tools
	"/opt/SEGGER/JLink"
	"/opt/mergehex"
	"/opt/nrfjprog"
	# Dart
	"$HOME/.pub-cache/bin"
	# Go
	"$GOPATH/bin"
	# Rust
	"$HOME/.cargo/bin"
	# Python
	"$HOME/.poetry/bin"
	# Home
	"$HOME/.local/bin"
	"$HOME/bin"
)
if [[ "${UNAME}" = "Darwin" && "${ARCH}" = "arm64" ]]; then
	CUSTOM_PATH+="${BREW_HOME}/bin"
fi
type npm >/dev/null 2>&1 && CUSTOM_PATH+=$(npm bin -g 2>/dev/null)

for p in $CUSTOM_PATH; do
    [[ -d $p ]] && PATH="$p:$PATH"
done
export PATH
