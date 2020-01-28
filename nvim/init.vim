" init.vim (for neovim) by Wisut Hantanong

" Disable vi-compatibility to get VIM full power
set nocompatible

"" keys mappings
let mapleader=","           " comma is easier to get than back-slash

" Plugins using junegunn/vim-plug
" ==============================================================================

call plug#begin()

    "" code commenting
    " --------------------------------------------------------------------------
    Plug 'tomtom/tcomment_vim'

    "" editor configrations
    " --------------------------------------------------------------------------
    Plug 'editorconfig/editorconfig-vim'

    "" fancy status line
    " --------------------------------------------------------------------------
    Plug 'vim-airline/vim-airline'

    "" fancy gutter column
    " --------------------------------------------------------------------------
    Plug 'airblade/vim-gitgutter'

    "" color scheme
    " --------------------------------------------------------------------------
    Plug 'morhetz/gruvbox'

    "" dynamic highlight
    " --------------------------------------------------------------------------
    Plug 'junegunn/limelight.vim'

    "" fuzzy finder
    " --------------------------------------------------------------------------
    Plug 'ctrlpvim/ctrlp.vim'

    "" tmux pane / vim split using same key combination
    " --------------------------------------------------------------------------
    Plug 'christoomey/vim-tmux-navigator'

    " nerdtree
    " -----------------------------------------------------------------------------
    Plug 'scrooloose/nerdtree'

    "" text alignment
    " -----------------------------------------------------------------------------
    Plug 'junegunn/vim-easy-align'

    "" GhostText server
    " -----------------------------------------------------------------------------
    " Plug 'wizzup/vim-ghost', {'branch': 'nix'}

    "" editorconfig
    " -----------------------------------------------------------------------------
    Plug 'editorconfig/editorconfig-vim'

    "" autocompletion engine
    " --------------------------------------------------------------------------
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    "" linter
    " --------------------------------------------------------------------------
    Plug 'w0rp/ale'

    "" lsp client
    " --------------------------------------------------------------------------
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': './install.sh'}

    "" Nix
    " --------------------------------------------------------------------------
    Plug 'LnL7/vim-nix', { 'for': 'nix' }

    "" Python completion via deoplete using jedi
    " --------------------------------------------------------------------------
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }

    "" Rust completion via deoplete using rust racer
    " --------------------------------------------------------------------------
    " Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

    "" ghcid
    Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

call plug#end()
" ==============================================================================

" plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" airline - ale integration
let g:airline#extensions#ale#enabled = 1

" ale
" -----------------------------------------------------------------------------
" let g:ale_cursor_detail = 1
" let g:ale_linters = {'haskell': ['hlint']}
let g:ale_linters = {'haskell': ['cabal_ghc']}
" let g:ale_linters = {'haskell': ['ghc']}
" let g:ale_haskell_ghc_options = '-fno-code -v0 -Wall -Wcompat'

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

"" deoplete
" --------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option({
            \'ignore_case': v:true,
            \'complete_method':"omnifunc"
            \})

"" deoplete-rust
"
" let g:deoplete#sources#rust#racer_binary = $RACER_BIN
" let g:deoplete#sources#rust#rust_source_path = $RUST_SRC

" --------------------------------------------------------------------------
"" LanguageClient-neovim
" --------------------------------------------------------------------------
" use ale for diagnostic, LanguageClient is buggy
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
\ }
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" global settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line number, window viewing and formatting
set fo-=t                   " don't autowrap while typing
set foldcolumn=3            " display fold indicator
set foldenable              " enalbe folding
set foldmethod=syntax       " fold by syntax
set lazyredraw              " don't redraw while executing macros
set number                  " show line number
set scrolloff=4             " see more context around cursor
set showcmd                 " show visual-mode line selection count
set showmatch               " show matching brackets
set signcolumn=yes          " preserve space for sign (gutter)
set visualbell              " turn the 'beep' sound off
set wildmode=longest:full   " wildchar (tap) completion for command window
set wildmenu                " display all matching
set wildignorecase          " match case insensitive filename
set nowrap                  " no auto wrap text line
set ignorecase
set infercase
" set colorcolumn=80          " highlight col 80

"" tmux
" -----------------------------------------------------------------------------
"" send text starting from cursor to eol to right tmux's plan
"" FIXME: single quote (') is not send, need escaping
"" ex: 'h' send as h
"" ex: '\'h\'' send as 'h'
nnoremap <leader>sr y$:!tmux send-keys -t Right '<C-R>"' C-m <CR><CR>
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
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone

"" Colors
set bg=dark
" set t_Co=256                        " force vim to use 256 colors

colorscheme gruvbox

"" =============================================================================
"" AUTO COMMAND
"" =============================================================================
"" Put these in an autocmd group, so that we can delete them easily.
augroup myAuFiletype
    autocmd!

    "" python

    " autocmd FileType python nmap <buffer> <Leader>w :w<CR>:Neomake<CR>
    " autocmd FileType python nmap <buffer> <Leader>r :w<CR>:!python %<CR>
    " autocmd FileType python nmap <buffer> <Leader>ri :w<CR>:!python % < input<CR>

    " For all text files set 'textwidth' to 78 characters.
    " autocmd FileType haskell setlocal textwidth=78
    " autocmd FileType python  setlocal textwidth=78
    " autocmd FileType text    setlocal textwidth=78

    "" haskell
    " write buffer and run doctest

    " autocmd FileType haskell nmap <buffer> <Leader>dt :w<CR>:!doctest %<CR>

    " write and run
    " autocmd FileType haskell nmap <buffer> <Leader>r :w<CR>:!runhaskell %<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>ri :w<CR>:!runhaskell % < input<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>r :w<CR>:!stack exec runhaskell %<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>ri :w<CR>:!stack exec runhaskell % < input<CR>
    "
    " autocmd BufWinEnter *.hs setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    " autocmd BufWinLeave *.hs setlocal foldexpr< foldmethod<

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

"" =============================================================================
"" Misc and custom functions
"" =============================================================================
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

"" calculate text hash and replace the old one
function! HashBuffer()
  let md5=trim(system('md5sum ' . expand('%') . ' | cut "-d " -f1'))
  %s/%%%\<HASH.*%%%/\='%%%' . 'HASH-' . md5 . '%%%'/
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
