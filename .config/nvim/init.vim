"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim configuration file                                   "
" Author: Lisandro Fernandez <kelechul [at] gmail [dot] com>  "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Genereal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Full mouse support in the console
set mouse=a



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if $TERM == 'xterm'
  set t_Co=256
  set termguicolors
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
"set wildmenu "default
set wildmode=list:longest,full
set wildignorecase



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

" Intelligent indentation for C/C++
"set smartindent

" Text width for automatic word wrapping
" Zero value disable the feature
set textwidth=0
set wrapmargin=0

" Case insensitive on search
set ignorecase
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains
" an uppercase letter, it is case sensitive, otherwise, it is not
set smartcase

" Code autocompletion
set omnifunc=syntaxcomplete#Complete



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set noswapfile



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leaving modified buffers
set hidden



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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set python2 and python3 executable for plugin API
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" vim-plug (plugin manager)
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " requieres nodejs
Plug 'junegunn/fzf', {'dir': '~/opt/fzf'} " in case of fzf manual installation
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar' " requieres Exuberant Ctags or Universal Ctags
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline' " requieres Powerline fonts
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " requieres Nerd Fonts
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Initialize plugin system
call plug#end()

" Colorscheme for the 256-colored xterm
if &t_Co >= 256
  try
    colorscheme dracula
  catch
    " do nothing
  endtry
endif

" Plugin settings "

"" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"" nerdtree
nnoremap <Leader>nt :NERDTreeToggle<Enter>

"" fzf.vim
" Use ripgrep instead of grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"" Coc
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `{g` and `}g` to navigate diagnostics
nmap <silent> {g <Plug>(coc-diagnostic-prev)
nmap <silent> }g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>


nnoremap <C-p> :Files<Enter>
nnoremap <C-e> :Buffers<Enter>
nnoremap <Leader>rg :Rg<Enter>
nnoremap <Leader>ag :Ag<Enter>
nnoremap <Leader>tb :TagbarToggle<Enter>
