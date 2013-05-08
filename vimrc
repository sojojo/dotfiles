" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Sojo -set 256 color mode
set t_Co=256

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Taken from froseph - https://github.com/froseph/vimrc/blob/master/.vimrc
" Vundle setup
set nocompatible
filetype off

let init=0

" Initialize vundle if it does not exist
if !isdirectory(expand('$HOME/.vim/bundle/vundle'))
    let out = system('git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle')
    let init=1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundle managing Bundle
Bundle 'gmarik/vundle'

" Github managed Bundles
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
Bundle 'gregsexton/MatchTag'
Bundle 'tpope/vim-fugitive'
Bundle 'sophacles/vim-bundle-mako'
Bundle 'jelera/vim-javascript-syntax'
" Python syntax
Bundle 'python.vim--Vasiliev'
Bundle 'trailing-whitespace'
Bundle 'localvimrc'
" Templates syntax
Bundle 'mako.vim--Torborg'
Bundle 'mako.vim'

" Initialize vim bundles
if init
    BundleInstall
endif


" Local vimrc options
let g:localvimrc_name = 'local.vimrc'
let g:localvimrc_ask = 0

" Python
let python_highlight_all=1 " python.vim--Vasiliev option

" Indent Guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240
let g:indent_guides_start_level = 2

let g:mta_filetypes = {
            \ 'html' : 1,
            \ 'xhtml' : 1,
            \ 'xml' : 1,
            \ 'jinja' : 1,
            \ 'mako' : 1,
            \}

set laststatus=2
set statusline+=%{SyntasticStatuslineFlag()}\ %f%M%R\ (%l,%c\ %P)

" froseph config
set background=dark
"colorscheme solarized
syntax on
filetype on
filetype plugin indent on

set title
set history=120             " History
set autoindent		        " self-explanatory
set splitright                  " new window to the right on vsplit
set splitbelow                  " new window below on split
set showmode                    " Indicates when in Insert, Edit mode, etc.
set ruler

" Tab options
"set tabstop=4
"set shiftwidth=4
"set expandtab
"set smartindent

" Search options
set ignorecase		        " ignore case on searches
set smartcase		        " overrides ignorecase sometimes
set incsearch               " Turn on incremental search

" Auto commands
set textwidth=80
autocmd BufEnter * silent! lcd %:p:h
au FileType python set textwidth=80 " PEP-8 Friendly
au FileType mako set textwidth=80
au FileType javascript set textwidth=80
au FileType markdown set textwidth=80
au FileType mkd set textwidth=80

"set laststatus=2
set statusline+=%{SyntasticStatuslineFlag()}\ %f%M%R\ (%l,%c\ %P)

" Highlight the column we need to do a break
highlight ColorColumn ctermbg=237
let &colorcolumn=join(range(&textwidth+1,999),",")
set modeline

" Deletness
set backspace=indent,eol,start

" Sojojo config

" AUTOCOMPLETE
" Python - Pydiction
filetype plugin on
let g:pydiction_location='/home/sojojo/dotfiles/vim/bundle/pydiction/complete-dict'

" COLOR SCHEMES
" Python colorscheme
autocmd FileType python colorscheme molokai

