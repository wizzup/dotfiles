" init.vim (for nvim) by Wisut Hantanong

set nocompatible   " Disable vi-compatibility to get VIM full power

"" Plugins using junegunn/vim-plug
" =============================================================================
call plug#begin()

    "" fancy status line
    Plug 'vim-airline/vim-airline'

    "" color scheme
    Plug 'morhetz/gruvbox'

    "" linter
    Plug 'w0rp/ale'

    "" text alignment
    Plug 'junegunn/vim-easy-align'

    "" code commenting
    Plug 'tomtom/tcomment_vim'

    "" tmux pane / vim split using same key combination
    Plug 'christoomey/vim-tmux-navigator'

    "" NerdTree
    Plug 'scrooloose/nerdtree'

    "" fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    "" tpope plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    "" editorconfig
    Plug 'editorconfig/editorconfig-vim'

    "" Tags
    Plug 'majutsushi/tagbar'

    " "" GhostText server
    Plug 'wizzup/vim-ghost', {'branch': 'nix', 'do': ':GhostInstall'}

    " -------------------------------------------------------------------------
    "" file-type specific plugins
    " -------------------------------------------------------------------------

    "" Nix
    " -------------------------------------------------------------------------
    Plug 'LnL7/vim-nix'
    " -------------------------------------------------------------------------

    "" haskell
    " -------------------------------------------------------------------------
    " syntax highlight for haskell
    Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

    " ghcid (disable because annoying screen refreshing)
    Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

    " haskellwiki syntax
    Plug 'wizzup/haskellwiki.vim', { 'for': 'haskellwiki' }
    " -------------------------------------------------------------------------

call plug#end()
" =============================================================================

"" Plugins settings
" =============================================================================
let mapleader=","           " comma is easier to get than back-slash

"" Airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = 'Ξ'

"" tmux
" -----------------------------------------------------------------------------
"" send text starting from cursor to eol to right tmux's plan
"" FIXME: single quote (') is not send, need escaping
"" ex: 'h' send as h
"" ex: '\'h\'' send as 'h'
nnoremap <leader>sr y$:!tmux send-keys -t Right '<C-R>"' C-m <CR><CR>
" -----------------------------------------------------------------------------

"" vim-easy-align
" -----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" -----------------------------------------------------------------------------

""" ale
" -----------------------------------------------------------------------------
"" disable history log because it is too long
" let g:ale_history_log_output = 0
"" enable omnifunc completion
let g:ale_completion_enabled = 1
let g:ale_completion_max_suggestions = 50
"" define linters
let g:ale_linters = {'haskell':['hie']}
"" defined fixers
let g:ale_fixers = {'haskell':['brittany']}
"" only use the specify linters, don't try to use others
let g:ale_linters_explicit = 1
" -----------------------------------------------------------------------------

" nerdtree
" -----------------------------------------------------------------------------
nmap <Leader>nt :NERDTreeToggle<CR>
" -----------------------------------------------------------------------------

" tagbar
" -----------------------------------------------------------------------------
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
    \ }
" -----------------------------------------------------------------------------

" haskell-vim
" -----------------------------------------------------------------------------
" to disable smart indentation, (use syntax highlighting only)
" let g:haskell_indent_disable = 1
" -----------------------------------------------------------------------------

" global settings
" =============================================================================
"
" Line number, window viewing and formatting
set number                 " show line number
set fo-=t                  " don't autowrap while typing
set showmatch              " show matching brackets
set wildmode=list:longest  " make commmand completiton work like in shell
set scrolloff=4            " see more context around cursor
set lazyredraw             " don't redraw while executing macros
set showcmd                " show visual-mode line selection count
set foldenable             " enalbe folding
set foldmethod=syntax      " fold by syntax
set foldcolumn=3           " display fold indicator
set visualbell             " turn the 'beep' sound off
set scrolloff=2            " cursor scroll offset
set nowrap                 " no auto wrap text line
set textwidth=80           " default textwidth to 80
set colorcolumn=+1         " highlight col textwidth + 1 (81)

"" keys mappings
" -----------------------------------------------------------------------------

"" paste mode toggle
set pastetoggle=<F12>

" moving around multiple windows more easyly
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-l><C-w>l

" visual mode shift without loosing selection
vmap < <gv
vmap > >gv

" Syntax highlight (these setting need restarting vim)
syntax on           " enable syntax highlight
filetype plugin on
filetype indent on

" show list-chars
set list

" Tabs and r/l shift
set tabstop=4       " mostly of my work use 4 space indentation
set softtabstop=4   " count 4 spaces as a tab
set expandtab       " replace tab with spaces in normal mode
set shiftwidth=2    " shift 2 spaces each time (when reindent/autoindent)
set shiftround      " Round indent to nearest shiftwidth multiple

set smarttab        " work fluently with spaces as tab
set shiftround      " round indent to multiple of shiftwidth
set autoindent      " auto indent on next line insertion
set smartindent     " adj indent dept to where it should be

" splitting behaviour
set splitbelow
set splitright

" Searching
set hlsearch        " highlight current search keyword
set incsearch       " use incremental search
set ignorecase      " case insensitive search
set smartcase       " use smartcase
set path+=**        " recursive search (:find)
set wildmenu        " display all matching
set nowrapscan      " don't automatic to to beginning of file

" clear search lighlight
nmap <Leader><Space> :noh<CR>

"" folding
" fold toggle using space
nmap <Space> za

" I don't want to clean backup file so don't create it.
set nobackup
set nowritebackup
set noswapfile

" omnicompletion default to syntax
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

"" Colors
set bg=dark
set t_Co=256         " force vim to use 256 colors

colorscheme gruvbox

"" =============================================================================
"" AUTO COMMAND
"" =============================================================================
"" Put these in an autocmd group, so that we can delete them easily.
augroup myAuFiletype
    autocmd!

    " haskel source file,  write and run
    autocmd FileType haskell nmap <buffer> <Leader>r  :w<CR>:!runhaskell %<CR>
    autocmd FileType haskell nmap <buffer> <Leader>ri :w<CR>:!runhaskell % < input<CR>
    autocmd FileType haskell nmap <buffer> <Leader>rs :w<CR>:!stack exec runhaskell %<CR>
    autocmd FileType haskell nmap <buffer> <Leader>rsi :w<CR>:!stack exec runhaskell % < input<CR>
augroup END

augroup myAuBuffer
    autocmd!
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

"" Misc and custom functions
" =============================================================================
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"" remove all trailing whitespace
function! StripTrailingWhitespace()
    %s/\s\+$//e
endfunction

"" zoom/unzoom toggle
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
