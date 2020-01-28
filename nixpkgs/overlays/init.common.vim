" common init.vim (for neovim) by Wisut Hantanong

" Disable vi-compatibility to get VIM full power
set nocompatible

"" keys mappings
let mapleader=","           " comma is easier to get than back-slash

" global settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line number, window viewing and formatting
set fo-=t                   " don't autowrap while typing
set nofoldenable            " don't enalbe folding on start
set foldmethod=syntax       " fold by syntax
set lazyredraw              " don't redraw while executing macros
set number                  " show line number
set scrolloff=4             " see more context around cursor
set showcmd                 " show visual-mode line selection count
set showmatch               " show matching brackets
set visualbell              " turn the 'beep' sound off
set wildmode=longest:full   " wildchar (tap) completion for command window
set wildmenu                " display all matching
set wildignorecase          " match case insensitive filename
set nowrap                  " no auto wrap text line
set ignorecase
set infercase
set signcolumn=yes          " preserve space for sign (gutter)
" set colorcolumn=80          " highlight col 80
" set foldcolumn=3            " display fold indicator

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
set nocindent       " c-style indent sometime annoying for non-c code

" splitting behaviour
set splitbelow
set splitright

" Searching
set hlsearch        " highlight current search keyword
set incsearch       " use incremental search
set ignorecase      " case insensitive search
set smartcase       " use smartcase
set path+=**        " recursive search (:find)
set nowrapscan      " don't automatic to to beginning of file

" clear search lighlight
nmap <Leader><Space> :noh<CR>

" quick save
nmap <Leader>w :w<CR>

" I don't want to clean backup file so don't create it.
set nobackup
set nowritebackup
set noswapfile

" omnicompletion default to syntax
" set omnifunc=syntaxcomplete#Complete
" set completeopt=longest,menuone

let base16colorspace=256
set termguicolors
colorscheme base16-gruvbox-dark-medium

" plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" tmux
" -----------------------------------------------------------------------------
"" send text starting from cursor to eol to right tmux's plan
"" FIXME: single quote (') is not send, need escaping
"" ex: 'h' send as h
"" ex: '\'h\'' send as 'h'
nnoremap <leader>sr y$:!tmux send-keys -t Right '<C-R>"' C-m <CR><CR>

" for tmux to know vim is running (pane_title in tmux.conf)
set title

" -----------------------------------------------------------------------------

"" vim-airline
" --------------------------------------------------------------------------
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" nerdtree
" -----------------------------------------------------------------------------
" show hidden files
let NERDTreeShowHidden=1
nmap <Leader>nt :NERDTreeToggle<CR>

"" vim-EasyAlign
" -----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" rainbow
" -----------------------------------------------------------------------------
let g:rainbow_active = 1

"" =============================================================================
"" Misc and custom functions
"" =============================================================================
"" remove all trailing whitespace
function! StripTrailingWhitespace()
    %s/\s\+$//e
endfunction
