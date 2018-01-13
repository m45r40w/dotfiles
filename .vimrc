"------------------------------------
" default setting
"------------------------------------
syntax on
filetype on
filetype plugin on
set nobackup
set incsearch
set showmatch
set number
set ruler
set list
set hlsearch
set noundofile
set noautoindent
set paste
set ts=2 sw=2 expandtab
set backspace=indent,eol,start

"------------------------------------
" file setting 
"------------------------------------
set fileformats=unix,dos,mac
if has("autocmd")
  " 改行時にコメントしない
  " 改行時に勝手にインデントしない
  autocmd FileType * setlocal formatoptions-=ro noautoindent nosmartindent
  " ファイル種別による個別設定(初期設定ではexpandtabなのでその設定はいれない)
  " ts = tabstop, sts = softtabstop, sw = shiftwidth, tw = textwidth
  " ft = filetype
  autocmd FileType html,xhtml,css,javascript,yaml,ruby,coffee setlocal ts=2 sts=2 sw=2
  " autocmd FileType python     setlocal ts=4 sts=4 sw=4

  " ファイルを開いた時、読み込んだ時にファイルタイプを設定する
  autocmd BufNewFile,BufRead *.js setlocal ft=javascript
  autocmd BufNewFile,BufRead *.ejs setlocal ft=html
  autocmd BufNewFile,BufRead *.py setlocal ft=python
  autocmd BufNewFile,BufRead *.rb setlocal ft=ruby
  autocmd BufNewFile,BufRead Gemfile setlocal ft=ruby
  autocmd BufNewFile,BufRead *.coffee setlocal ft=coffee
  autocmd BufNewFile,BufRead *.ts setlocal ft=typescript
  autocmd BufNewFile,BufRead *.md setlocal ft=markdown
  autocmd BufNewFile,BufRead *.jade setlocal ft=markdown
  autocmd BufNewFile,BufRead *.gyp setlocal ft=json
  autocmd BufNewFile,BufRead *.cson setlocal ft=json
  autocmd BufNewFile,BufRead *.yml setlocal ft=yaml
  autocmd BufNewFile,BufRead *.yaml setlocal ft=yaml
  " ctagsファイルの設定ファイル
  " autocmd BufNewFile,BufRead *.rb set tags+=;$HOME/.ruby.ctags;
  " autocmd BufNewFile,BufRead *.js set tags+=;$HOME/.javascript.ctags;

endif
  "
set diffopt=vertical
"逆に水平分割にしたければ以下を設定する。
"set diffopt=horizontal


"ChangeLog
let g:changelog_timeformat = "%Y-%m-%d" 
let g:changelog_username = "vancho"

"nmap <Esc> <S-Space><Esc>
""Escを2回連打すると検索結果が消える
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"spacex2で行選択
nmap <Space><Space> V

"全角スペースのハイライト
augroup highlightDoubleByteSpace
 autocmd!
 autocmd VimEnter,Colorscheme * highlight DoubleByteSpace term=underline ctermbg=LightMagenta guibg=LightMagenta
 autocmd VimEnter,WinEnter,BufRead * match DoubleByteSpace /　/
augroup END

"------------------------------------
" Dein.vim setting
"------------------------------------
"
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein/'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('mattn/emmet-vim')
call dein#add('powerline/powerline', {'rtp': 'powerline/bindings/vim/'})

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
call dein#add('mattn/emmet-vim')
call dein#add('csscomb/vim-csscomb')
call dein#add('AtsushiM/search-parent.vim')
call dein#add('tpope/vim-surround')
call dein#add('othree/html5.vim')
call dein#add('cakebaker/scss-syntax.vim')
" call dein#add('AtsushiM/sass-compile.vim')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('jelera/vim-javascript-syntax')

" vim color scheme plugin
call dein#add('nanotech/jellybeans.vim')
call dein#add('altercation/vim-colors-solarized')
call dein#add('chriskempson/tomorrow-theme')
call dein#add('tomasr/molokai')
call dein#add('sjl/badwolf')
call dein#add('vim-scripts/twilight')

" vim markdown plugins 
call dein#add('plasticboy/vim-markdown')

" Required:
call dein#end()

" ------------------------------------
" colorscheme
" ------------------------------------
colorscheme twilight
"let g:molokai_original = 1
"let g:rehash256 = 1
set background=dark
highlight Normal ctermbg=none

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
   call dein#install()
endif

" ------------------------------------
" Unite
" ------------------------------------
"入力モードで開始する
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使用したファイル一覧
noremap <C-Z> :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" ------------------------------------
" vimfiler setting
" ------------------------------------
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" ------------------------------------
" powerline setting
" ------------------------------------
source $HOME/.anyenv/envs/pyenv/versions/2.7.13/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set laststatus=2
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"------------------------------------
" vim-markdown setting 
"------------------------------------
let g:vim_markdown_folding_disabled = 1
" autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

"------------------------------------
" emmet setting
"------------------------------------
let g:user_emmet_leader_key = '<c-y>'
let g:user_emmet_install_global = 0
let g:user_emmet_mode = 'inv'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
    \ 'lang' : 'ja',
    \}
augroup EmmitVim
    autocmd!
      autocmd FileType * let g:user_emmet_settings.indentation = '  '[:&tabstop]
    augroup END
    autocmd FileType html,css,scss EmmetInstall

"------------------------------------
" CSS comb setting
"------------------------------------
" Map bc to run CSScomb. bc stands for beautify css
autocmd FileType css noremap <buffer> <leader>bc :CSScomb<CR>
" Automatically comb your CSS on save
autocmd BufWritePre,FileWritePre *.css,*.less,*.scss,*.sass silent! :CSScomb

"------------------------------------
" vim-css3-syntax, vim-javascript, html5.vim
"------------------------------------
syn keyword htmlTagName contained article aside audio bb canvas command
syn keyword htmlTagName contained datalist details dialog embed figure
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time
syn keyword htmlTagName contained source figcaption
syn keyword htmlArg contained autofocus autocomplete placeholder min max
syn keyword htmlArg contained contenteditable contextmenu draggable hidden
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget
syn keyword htmlArg contained formaction formenctype formmethod
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"

"------------------------------------
"" sass
"------------------------------------
"let g:sass_compile_auto = 1
"let g:sass_compile_cdloop = 5
"let g:sass_compile_cssdir = ['css', 'stylesheet']
"let g:sass_compile_file = ['scss', 'sass']
"let g:sass_started_dirs = []

"autocmd FileType less,sass  setlocal sw=2 sts=2 ts=2 et
"au! BufWritePost * SassCompile
"au BufRead,BufNewFile *.scss set filetype=sass

"set rtp+=$HOME/.anyenv/envs/pyenv/versions/2.7.13/lib/python2.7/site-packages/powerline/bindings/vim

" ------------------------------------
" 改行してインデント
" ------------------------------------
inoremap {<Enter> {<CR><CR>}<ESC>ki<TAB>
inoremap [<Enter> [<CR><CR>]<ESC>ki<TAB>
inoremap (<Enter> (<CR><CR>)<ESC>ki<TAB>
