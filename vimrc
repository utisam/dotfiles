scriptencoding utf-8

" ターミナル接続を高速化
set ttyfast

""""""""""""""""""
" 読み込み・保存 "
""""""""""""""""""

" 文字コードの設定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
" ファイルのコメントによる設定
set modeline
" 保存していない場合に失敗せず確認ダイアログを出す
set confirm
" 外部のファイルの変更を自動でリロード
set autoread
" リロードしたらメッセージを表示
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" Undo 情報を保存
try
    set undofile
    set undodir=~/.vim/undo
catch
endtry

""""""""""""""""
" キーバインド "
""""""""""""""""

" vt100/xterm のカーソルキー対策
" https://vim-jp.org/vimdoc-ja/term.html#xterm-cursor-keys
set notimeout
set ttimeout
set timeoutlen=100
" バックスペースで削除可能にする
set backspace=start,eol,indent
" 行頭・行末からの左右移動で行を跨ぐ
set whichwrap=b,s,[,],<,>,~
" dd/D と yy/Y で一貫性を持たせる
nnoremap Y y$
" increment/decrement the next number
nnoremap + <C-a>
nnoremap - <C-x>
" *: ビジュアルモードで選択した文字列を検索
vnoremap * "zy:let @/ = @z<CR>n

""""""""
" 表示 "
""""""""

"カラースキーマを設定
colorscheme slate
" シンタックスハイライト
if &t_Co > 1
	syntax enable
endif
" □とか○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" 新しい行のインデントを現在行と同じにする
set autoindent
" カーソルラインを表示する
set cursorline
" 行をできる限り表示, 制御文字を 16 進数で表示
set display=lastline,uhex
" 空白文字を表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 行番号を表示
set number
" 補完のポップアップメニューの高さの最大値
set pumheight=10
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" スクロールする時に下が見えるようにする
set scrolloff=5
" 入力中のコマンドを表示する
set showcmd
" 対応するカッコを 0.1 秒だけ表示
set showmatch
set matchtime=1
"ウインドウタイトルを設定する
set title
" 補完時の一覧表示機能有効化
set wildmenu wildmode=list:full
" ステータスラインを常に表示
set laststatus=2
" ステータスラインの内容
set statusline=%F%m%r%h%w\%=[%Y\|%{&ff}\|%{&fileencoding}]\ %L\ lines\ (%04l,%04v)
" ハイライトは下線のみ
highlight clear CursorLine
highlight CursorLine cterm=underline gui=underline
" タブの表示を設定
function! s:tabpage_label(n)
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif
  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)
  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける
  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))
  let label = "[" . a:n . "]" . no . mod . sp . fname
  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction
function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  return tabpages
endfunction
set tabline=%!MakeTabLine()

""""""""""""""
" 検索・置換 "
""""""""""""""

" 検索時にハイライト
set hlsearch
" インクリメンタル検索を有効化
set incsearch

""""""""
" 整形 "
""""""""

set formatoptions=tcqj
" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
" タブをスペースに置き換える
set expandtab 
" タブ幅の設定
set tabstop=4
set shiftwidth=4
set softtabstop=4

