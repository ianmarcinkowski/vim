" 1: important {{{
set nocompatible
" disable before calling vundle
filetype off

" set this here because of unicode chars in listchars below
set encoding=utf-8

" }}}

" plugins using plug.vim {{{

call plug#begin('~/.vim/plugged')

" From mmazer vimrc (https://github.com/mmazer/vim/blob/master/vimrc)

" Functional plugins
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'itchyny/lightline.vim'

" HTML autocompletion
Plug 'mattn/emmet-vim'

" CTRLP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'sgur/ctrlp-extensions.vim'

" file types
Plug 'tpope/vim-markdown'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'davidoc/taskpaper.vim'
Plug 'groenewege/vim-less'
Plug 'ap/vim-css-color'
Plug 'vim-scripts/paredit.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'evidens/vim-twig'


call plug#end()
"}}}

"}}} 1: important

" 2: moving around, searching and patterns {{{
set hlsearch
" }}}

" 3: tags {{{
" }}}

" 4: displaying text {{{
set scrolloff=2
set listchars=tab:▸\ ,trail:·,nbsp:¬
set number
" }}}

" 5: syntax, highligthing and spelling {{{1

filetype plugin on
syntax on
syntax sync minlines=256
set cursorline

set spelllang=en
set spellfile=~/.vim/spell/spellfile.en.add
" }}}

set directory=~/.vim/swap//,.
set backspace=0
set softtabstop=4
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set sw=4
set bg=dark
set ai
set ruler
set cc=80,100

" Vim clipboard to X11 clipboard
set clipboard=unnamedplus

if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\   " Filename
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=%h%m%r%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Flake 8
autocmd BufWritePost *.py call Flake8()
let g:flake8_max_line_length=99
" Ignore over-indentation error
let g:flake8_ignore="E126,F403,E712,E711"

" }}}

" 18: mapping {{{1

" try to reduce delays waiting for multi-key combinations in tmux
" tmux needs `set -s escape-time 0` for these to work
set ttimeout timeout ttimeoutlen=125

"keep original motion: repeat latest f, t, F or T in opposite direction
noremap ,, ,
let mapleader = ","
let g:mapleader = ","


:nmap <F1> <nop>
:imap <F1> <nop>

" window navigation
:imap <silent> <C-w> <C-o><C-w>
"up
:map <silent> <C-k> :wincmd k<CR>
"down
:map <silent> <C-j> :wincmd j<CR>
"left
:map <silent> <C-h> :wincmd h<CR>
"right
:map <silent> <C-l> :wincmd l<CR>

" window sizing
" decrease
:map <silent> <leader>- <C-W>-

:map <silent> <leader>p :set invpaste<CR>
:map <silent> <leader>n :set invnumber<CR>

" window splitting
:nmap <leader>ss :split<CR>
:nmap <leader>sv :vsplit<CR>

" swap windows
:nmap <leader>w <C-w>r<CR>

" diff commands
:nmap <leader>dg :diffget<CR>
:nmap <leader>dp :diffput<CR>

" Prettify JSON using python
:nmap <leader>j :%!python -m json.tool<CR>

" Change case for the current word
:nmap <leader>U gUiw
:nmap <leader>u guiw

" folding
nnoremap <space> za

" Disable K
noremap K <NOP>

" Kill all trailing whitespace with one keypress!
:map <F3> :%s/\s\+$//g<cr>

" Make all buffers equal size
:nmap <leader>= <C-w>=

" Change case for the current word
:nmap <leader>s :source ~/.vim/vimrc<CR>

" Nerd tree
map <C-n> :NERDTreeToggle<CR>

" }}}

" 21: command line editing {{{1
set wildmenu
set wildmode=longest,list

set wildignore+=.hg,.git,.svn,CVS,target,.settings
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.jar,*.war,*.o,*.obj,*.exe,*.dll
set wildignore+=*.DS_Store
set wildignore+=*.orig      " merge resolution files

" }}}

" 27: various: autocmd {{{

" autocommands {{{
if has("autocmd")
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    match ExtraWhitespace /\s\+$\| \+\ze\t/
    match ExtraWhitespace /[^\t]\zs\t\+/

    " highlight PreBracketSpaces ctermbg=green guibg=green
    " match PreBracketSpaces /\w\s(/

    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    au InsertLeave * match ExtraWhitespace /\s\+$/

    au BufReadPost *inc set filetype=php
    au BufReadPost *module set filetype=php
    au BufReadPost *mako set filetype=html
    au BufReadPost *less set filetype=less
    au BufReadPost *py.* set filetype=python

    augroup preview
        autocmd CompleteDone * pclose
    augroup END

    " remove trailing whitespace
    augroup trailing_whitespace
        autocmd! FileType vim,css,groovy,java,javascript,less,php,scala,taskpaper,python autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END

    " php stuff
    augroup php
        autocmd FileType php setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
    augroup END

    augroup keyword
        autocmd FileType html,css,javascript setlocal iskeyword+=-
    augroup END

    augroup javascript_files
        autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 foldmethod=indent
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    augroup END

    augroup vim_files
        autocmd filetype vim set foldmethod=marker
    augroup END

    augroup html_files
        autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual
        autocmd FileType html setlocal autoindent
    augroup END

    augroup jsp_files
        autocmd FileType jsp setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual autoindent
    augroup END

    augroup json_files
        autocmd FileType json command! Format :%!python -m json.tool<CR>
        autocmd FileType json setlocal foldmethod=syntax
        autocmd FileType json setlocal foldnestmax=10
    augroup END

    augroup xml_files
        autocmd FileType xml setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=syntax
    augroup END

    augroup markdown_files
        autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setlocal wrap linebreak nolist
    augroup END

    augroup diff_mode
        autocmd FilterWritePre * if &diff | nnoremap <buffer> dc :Gdoff<CR> | nnoremap <buffer> du :diffupdate<CR> | endif
    augroup END

    augroup conf_files
        autocmd! BufRead *.conf setlocal ft=conf
        autocmd FileType conf setlocal shiftwidth=2 softtabstop=2 tabstop=2 foldmethod=manual autoindent
    augroup END
endif "}}}
" }}}

" 28: plugin settings {{{1

" ctrlp:
nmap <space> [ctrlp]
nnoremap <silent> [ctrlp]a :<C-u>CtrlPBookmarkDirAdd<cr>
nnoremap <silent> [ctrlp]b :<C-u>CtrlPBuffer<cr>
nnoremap <silent> [ctrlp]c :<C-u>CtrlPCmdline<cr>
nnoremap <silent> [ctrlp]C :<C-u>CtrlPClearCache<cr>
nnoremap <silent> [ctrlp]d :<C-u>CtrlPDir<cr>
nnoremap <silent> [ctrlp]f :<C-u>CtrlP<cr>
nnoremap <silent> [ctrlp]k :<C-u>CtrlPMark<cr>
nnoremap <silent> [ctrlp]m :<C-u>CtrlPMixed<cr>
nnoremap <silent> [ctrlp]o :<C-u>CtrlPBookmarkDir<cr>
nnoremap <silent> [ctrlp]r :<C-u>CtrlPRegister<cr>
nnoremap <silent> [ctrlp]q :<C-u>CtrlPQuickfix<cr>
nnoremap <silent> [ctrlp]s :<C-u>CtrlPFunky<cr>
nnoremap <silent> [ctrlp]t :<C-u>CtrlPBufTag<cr>
nnoremap <silent> [ctrlp]u :<C-u>CtrlPMRUFiles<cr>
nnoremap <silent> [ctrlp]y :<C-u>CtrlPYankring<cr>


let g:ctrlp_extensions = ['quickfix', 'dir', 'undo', 'line', 'changes', 'mixed', 'buffertag', 'bookmarkdir', 'funky', 'mark', 'register']
let g:ctrlp_match_window_bottom = 1 " Show at top of window
let g:ctrlp_working_path_mode = 'ra' " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_root_markers = ['.top', '.project', '.ctrlp']
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = {
    \ 'dir':  '.git\|.svn\|target\|node_modules\|.settings'
    \ }

let g:ctrlp_funky_syntax_highlight = 1
if executable('ag')
    let g:ctrlp_user_command = 'ag -l --nocolor --follow -g "" %s'
    if has('win32')
        let g:ctrlp_use_caching = 1
        let g:ctrlp_clear_cache_on_exit = 0
    else
        let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
        let g:ctrlp_use_caching = 0
    endif
endif

" ctrlp_buftag
let g:ctrlp_buftag_types = {
    \ 'javascript'  : '--language-force=js',
    \ 'css'         : '--language-force=css',
    \ 'gsp'         : '--language-force=XML',
    \ 'xml'         : '--language-force=XML',
    \ 'spring'      : '--language-force=XML',
    \ 'jsp'         : '--language-force=XML',
    \ 'html'        : '--language-force=XML',
    \ 'taskpaper'   : '--language-force=Taskpaper',
    \ 'wsdl'        : '--language-force=wsdl',
    \ 'markdown'    : '--language-force=markdown'
    \ }

" Nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}
