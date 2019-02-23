"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration file                                      "
" Author: Lisandro Fernandez <kelechul [at] gmail [dot] com>  "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Genereal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

" Enable file type detection
filetype plugin on

" Full mouse support in the console
set mouse=a



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on color syntax highlighting
syntax on

if $TERM == 'xterm'
  set t_Co=256
endif

" Colorscheme for the 256-colored xterm
if &t_Co >= 256
  try
    colorscheme snazzy
  catch
    " do nothing
  endtry
endif

" Colorscheme for GVim
if has('gui_running')
  try
    colorscheme solarized
    set background=dark
  catch
    " do nothing
  endtry
endif

" Enable line numbers
set number

" Show cursorline and colorcolumn only in active window
augroup HighlightActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline colorcolumn=81
  autocmd WinLeave * setlocal nocursorline colorcolumn=0
augroup END

" Highlight matching braces
set showmatch

" Bash-like <TAB> command line autocompletion
set wildmenu
set wildmode=list:longest,full
set wildignorecase

" Always show the statusline
set laststatus=2

" Show the cursor position in the status line
set ruler



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Changes the width of the TAB character
set tabstop=4
" Affects what happens when you press the <TAB> or <BACKSPACE>
" keys
set softtabstop=4
" Affects what happens when you press >>, << or ==
" It also affects how automatic indentation works
set shiftwidth=4
" On pressing tab, insert 'softtabstop' amount of space
" characters
set expandtab

" Copy the indentation from the previous line when starting a
" new line
set autoindent
" Intelligent indentation for C/C++
"set smartindent

" Text width for automatic word wrapping
" Zero value disable the feature
set textwidth=0
set wrapmargin=0

" Incremental search
set incsearch
" Case insensitive
set ignorecase
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains
" an uppercase letter, it is case sensitive, otherwise, it is not
set smartcase

" Allow backspacing over everything in insert mode
"set backspace=indent,eol,start

" Code autocompletion
set omnifunc=syntaxcomplete#Complete



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set noswapfile

" Set direcotries to place backup, swap and undo files
" Double trailing slashes in the path tells vim to enable a
" feature where it avoids name collisions using fullpath of the
" files being edited
" NOTE: must create these directories first
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set undodir=~/.vim/undo//




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leaving modified buffers
set hidden

" Save current view settings on a per-window, per-buffer basis
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Redefine leader key
let mapleader = ","

" Treat long lines as break lines
map j gj
map k gk

" Yank text from current position until the end of the line
map Y y$

" When indent in visual mode, continue the block selection
vnoremap < <gv
vnoremap > >gv

" When no typing, maps <Enter>, <Backspace> and <Space> to
" scroll one line down, scroll one line up and center to
" current line, respectively.
nnoremap <Enter> <C-e>
nnoremap <Backspace> <C-y>
nnoremap <Space> zz

" Cycles through listed buffers
nnoremap <C-l> :bnext<Enter>
nnoremap <C-h> :bprevious<Enter>

nnoremap <Leader>b :buffer<Space>
nnoremap <Leader>l :buffers<Enter>:buffer<Space>

" Toogle highligh search and show current status
nnoremap <Leader>hs :set hlsearch!<Enter> \| :set hlsearch? <Enter>

" Disable mouse scrolling in insert and visual mode
" Insert mode
imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
imap <ScrollWheelLeft> <nop>
imap <S-ScrollWheelLeft> <nop>
imap <C-ScrollWheelLeft> <nop>
imap <ScrollWheelRight> <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>
" Visual mode
vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelLeft> <nop>
vmap <S-ScrollWheelLeft> <nop>
vmap <C-ScrollWheelLeft> <nop>
vmap <ScrollWheelRight> <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utils
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Removes trailing spaces
function! TrimWhiteSpace()
  " The 'e' flag tells ':substitute' that not finding a match
  " is not an error
    %s/\s\+$//e
endfunction
