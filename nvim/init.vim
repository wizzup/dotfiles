" init.vim (for nvim) by Wisut Hantanong
"
set nocompatible   " Disable vi-compatibility to get VIM full power

""====================================================================
" Plugins using junegunn/vim-plug
""====================================================================
"
call plug#begin()

    "" backend/required for others plugs (ghcmod-vim)
    Plug 'shougo/vimproc', {'do' : 'make'}

    "" tmux pane / vim split using same key combination
    Plug 'christoomey/vim-tmux-navigator'

    "" fuzzy finder
    Plug 'ctrlpvim/ctrlp.vim'

    "" code commenting
    Plug 'tomtom/tcomment_vim'

    "" text alignment
    Plug 'junegunn/vim-easy-align'

    "" autocompletion engine
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    "" tpope plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    "" NerdTree
    Plug 'scrooloose/nerdtree'

    "" fancy status line
    Plug 'vim-airline/vim-airline'

    "" linter
    Plug 'w0rp/ale'

    "" editorconfig
    Plug 'editorconfig/editorconfig-vim'

    "" color scheme
    Plug 'morhetz/gruvbox'

    "" Tags
    Plug 'majutsushi/tagbar'

    "" GhostText server
    Plug 'wizzup/vim-ghost', {'branch': 'nix', 'do': ':GhostInstall'}

    "" file-type specific plugins
    ""----------------------------------------------------------------

    "" python
    ""----------------------------------------------------------------
    Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }

    "" haskell
    ""----------------------------------------------------------------
    " haskellwiki syntax
    " Plug 'wizzup/haskellwiki.vim', { 'for': 'haskellwiki' }
    " syntax highlight for haskell
    " Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
    " ghc-mod integration
    " Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
    " completion via ghc-mod
    " Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
    "
    " hoogle integration
    " Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
    " Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
    " Plug 'Haskell-Cuteness'

    "" Nix
    Plug 'LnL7/vim-nix'

    "" javascript
    Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

    "" purescript
    Plug 'purescript-contrib/purescript-vim', { 'for': 'purescript' }

    "" typescript
    " Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

    "" HTML
    Plug 'mattn/emmet-vim', { 'for': 'html' }

call plug#end()
""====================================================================

""====================================================================
" plugins settings
""====================================================================
let mapleader=","           " comma is easier to get than back-slash

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" deoplete
let g:deoplete#enable_at_startup = 1

" ale
let g:ale_history_log_output = 0
let g:ale_linters = {'haskell':['ghc-mod', 'hlint']}

" nerdtree
nmap <Leader>nt :NERDTreeToggle<CR>

" tagbar
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

" haskell-vim
let g:haskell_indent_disable = 1

" ghcmod-vim
autocmd FileType haskell nmap <buffer> tw :GhcModTypeInsert<CR>     " insert function type
autocmd FileType haskell nmap <buffer> ts :GhcModSplitFunCase<CR>   " split function case
autocmd FileType haskell nmap <buffer> tq :GhcModType<CR>           " query function type
autocmd FileType haskell nmap <buffer> te :GhcModTypeClear<CR>      " clear type query highlight

" neco-ghc
" let g:haskellmode_completion_ghc = 0
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" let g:necoghc_debug = 1
" let g:necoghc_use_stack = 1
" let g:necoghc_enable_detailed_browse = 1

""====================================================================

" ------------------------------------------------------------------------
" filetype specific settings
" ------------------------------------------------------------------------
"
" haskell
"
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" python
"
" autocmd FileType python nmap <buffer> <Leader>w :w<CR>:Neomake<CR>
autocmd FileType python nmap <buffer> <Leader>r :w<CR>:!python %<CR>
autocmd FileType python nmap <buffer> <Leader>ri :w<CR>:!python % < input<CR>
" ------------------------------------------------------------------------

" javascript
let g:tern#command=['tern']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Line number, window viewing and formatting
set number                  " show line number
set nowrap                  " no auto wrap text line
set fo-=t                   " don't autowrap while typing
set showmatch               " show matching brackets
set wildmode=list:longest   " make commmand completiton work like in shell
set scrolloff=4             " see more context around cursor
set lazyredraw              " don't redraw while executing macros
set showcmd                 " show visual-mode line selection count
set foldenable              " enalbe folding
set foldmethod=syntax       " fold by syntax
set foldcolumn=3            " display fold indicator
set visualbell              " turn the 'beep' sound off

"" keys mappings
"
" paste mode toggle
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
syntax on
filetype plugin on
filetype indent on

" show list-chars
set list

" Tabs and r/l shift
set tabstop=4       " mostly of my work I use 4 space indentation
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
nmap <Leader><Space> :noh<CR>

" I don't want to clean backup file so don't create it.
set nobackup
set nowritebackup
set noswapfile

" omnicompletion default to syntax
set omnifunc=syntaxcomplete#Complete

set t_Co=256                        " force vim to use 256 colors

set bg=dark
colorscheme gruvbox

"" ================================================================================
"" AUTO COMMAND
"" ================================================================================
"" Put these in an autocmd group, so that we can delete them easily.
augroup myAuFiletype
    autocmd!

    "" haskel source file
    " write and make
    " autocmd FileType haskell nmap <buffer> <Leader>w :w<CR>:Neomake<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>w :w<CR>:make<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>w :w<CR>:GhcModCheck<CR>

    " autocmd FileType haskell setlocal makeprg=ghc-mod\ check\ %
    "" autocmd FileType haskell setlocal makeprg=ghc\ -fno-code\ %

    " write and run
    autocmd FileType haskell nmap <buffer> <Leader>r :w<CR>:!runhaskell %<CR>
    autocmd FileType haskell nmap <buffer> <Leader>ri :w<CR>:!runhaskell % < input<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>r :w<CR>:!stack exec runhaskell %<CR>
    " autocmd FileType haskell nmap <buffer> <Leader>ri :w<CR>:!stack exec runhaskell % < input<CR>

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType haskell setlocal textwidth=78
    autocmd FileType python  setlocal textwidth=78
    autocmd FileType text    setlocal textwidth=78
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

"" ================================================================================
"" Misc and custom functions
"" ================================================================================
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

function StripTrailingWhitespace()
    %s/\s\+$//e
endfunction

"" ================================================================================
"" old/unused stuffs (for reference)
"" ================================================================================

" " custom completion by Tap (code taken form 'Hacking vim' book)
" set completeopt=longest,menuone
" function! SuperCleverTab()
"     "check if at beginning of line or after a space
"     if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"         return ",<Tab>"
"     else
"         " do we have omni completion available
"         if &omnifunc != ''
"             " use omni-completion first
"             return "\<C-X>\<C-O>"
"         elseif &dictionary != ''
"             " no omni completion, try dictionary completio
"             return "\<C-X>\<C-K>"
"         else
"             " no omni completion nor dictionary completion
"             " use known-word completiton
"             return "\<C-N>"
"         endif
"     endif
" endfunction

" " bind SuperCleverTab function to the <leader>tab key
" imap <Leader><Tab> <C-R>=SuperCleverTab()<cr>
" folding
" fold toggle using space
" nmap <Space> za
"
" reStructuredText
" autocmd FileType rst nmap <Leader>v :!xdg-open /tmp/%<.pdf<CR><C-l>
" autocmd FileType rst nmap <Leader>c :w<CR> :!rst2pdf % -o /tmp/%<.pdf<CR><C-l>

" bash script
" autocmd FileType sh nmap <Leader>r :w<CR> :source %<CR>
"
""--------------------------------------------------------------------
"" python
""--------------------------------------------------------------------

" Plug 'klen/python-mode'
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = "vnew"
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
" map <Leader>g :call RopeGotoDefinition()<CR>
