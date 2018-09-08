""" init
augroup MyVimrc
	autocmd!
augroup END

if &compatible
	set nocompatible
endif


""" envs
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME


""" plugins
let s:dein_dir = g:cache_home . '/dein'

let s:dein_repo = 'Shougo/dein.vim'
if &runtimepath !~# s:dein_repo
	let s:dein_repo_dir = s:dein_dir . '/repos/github.com/' . s:dein_repo

	if !isdirectory(s:dein_repo_dir)
		call system('git clone https://github.com/' . s:dein_repo . ' ' . shellescape(s:dein_repo_dir))
	endif

	execute 'set runtimepath+=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#load_toml(g:config_home . '/nvim/dein.toml', {'lazy' : 0})
	call dein#load_toml(g:config_home . '/nvim/dein_lazy.toml', {'lazy' : 1})

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
	call dein#remote_plugins()
endif


""" edit
filetype plugin indent on

set enc=utf-8
set fencs=utf-8,cp932

set swapfile
set nobackup
if has('persistent_undo')
	execute 'set undodir=' . g:cache_home . '/nvim/undo'
	set undofile
endif

set autoread
set autowrite

set hidden

set confirm

set expandtab

set mouse=a


""" view
syntax on

set list
set listchars=tab:»-,trail:￮,eol:￩,extends:»,precedes:«,nbsp:￭
augroup MyVimrc
	autocmd ColorScheme * highlight UnicodeSpaces cterm=underline ctermfg=0 ctermbg=1 gui=underline guifg=#000000 guibg=#800000
	autocmd VimEnter,WinEnter * match UnicodeSpaces /\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000/
augroup END

set number

set showcmd
set noshowmode

set cursorline
set nocursorcolumn

set smartindent

set novisualbell

set showmatch

set laststatus=2

set wildmode=list:longest

set tabstop=2
set shiftwidth=2


""" search
set ignorecase
set smartcase

set hlsearch

set incsearch

set wrapscan


""" key
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
noremap <Home> <Nop>
noremap <End> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
inoremap <Home> <Nop>
inoremap <End> <Nop>
