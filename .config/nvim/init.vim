if &compatible
  set nocompatible
endif

augroup fileTypeIndent
  autocmd!
  " 言語ごとのインデント制御
  autocmd BufRead,BufNewFile *.rs setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au FileType go setlocal sw=4 ts=4 sts=4 noet
  au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
  au FileType *.tmpl setlocal sw=4 ts=4 sts=4 noet
  " 末尾の半角スペースを削除
  autocmd BufWritePre * :%s/\s\+$//ge
  " 全角文字のハイライト
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" For ale
augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" set colorscheme
if (has("termguicolors"))
  set termguicolors
endif

" map leader key
let mapleader = "\<Space>"

" https://qiita.com/yuku_t/items/6db331e7084f88b43fe4
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim-2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim-3/bin/python'
let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir = s:dein_cache_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#add('neoclide/coc.nvim', {'merge':0, 'rev': 'release'})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


filetype plugin indent on
syntax enable
colorscheme tender

set encoding=UTF-8
set number
"set cursorline
set ruler
set history=2000
set helplang=en
set formatoptions+=mM
set noswapfile
set nobackup
set clipboard+=unnamedplus
set list  " 不可視文字を表示する
set listchars=tab:>-,trail:.  " タブを >--- 半スペを . で表示する
"Tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
"Indent
set autoindent
set smartindent
" match
set showmatch
set matchtime=1
