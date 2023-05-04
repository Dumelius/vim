
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" set backupdir=~/.vim/backup/
set undodir=~/.vim/undo/

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set nocompatible
set backspace=indent,eol,start
set history=200
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate
set incsearch
set nrformats-=octal
map Q gq
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
set mouse=a
endif

syntax on
filetype plugin indent on
autocmd Syntax csound normal zR

" Kirjoittamista varten
" http://www.terminally-incoherent.com/blog/2013/06/17/using-vim-for-writing-prose/

" setlocal formatoptions=ant setlocal textwidth=80 setlocal wrapmargin=0
" setlocal noautoindent setlocal nocindent setlocal
"nosmartindent setlocal indentexpr=

" Kirjoittamista varten
" https://joehallenbeck.com/the-glories-of-text-files-on-using-vim-for-code-and-prose/
"
func! WordProcessorMode()
  set formatoptions=aw2tq
  set laststatus=0
  set foldcolumn=12
  " set nonumber
  highlight! link FoldColumn Normal
  " setlocal spell spelllang=fi_fi
  " nnoremap \s eas<C-X><C-S>
endfu
com! Prose call WordProcessorMode()

func! CodeMode()
  set formatoptions=cql
  " set number
  set ruler
  set laststatus=1
  set foldcolumn=0
  " setlocal nospell
endfu
com! Code call CodeMode()
call CodeMode()
