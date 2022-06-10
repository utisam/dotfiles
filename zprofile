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

CUSTOM_PATH=(
	# Homebrew opts
	"/usr/local/opt/coreutils/libexec/gnubin"
	"/usr/local/opt/gettext/bin"
	"/usr/local/opt/gnu-sed/libexec/gnubin"
	"/usr/local/opt/grep/libexec/gnubin"
	"/usr/local/opt/llvm/bin"
	"/usr/local/opt/make/libexec/gnubin"
	"/usr/local/opt/gnu-tar/libexec/gnubin"
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
type npm >/dev/null 2>&1 && CUSTOM_PATH+=$(npm bin -g 2>/dev/null)

for p in $CUSTOM_PATH; do
    [[ -d $p ]] && PATH="$p:$PATH"
done
export PATH
