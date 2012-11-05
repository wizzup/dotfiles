" .vimrc by Wisut Hantanong

set nocompatible   " Disable vi-compatibility to get VIM full power

" Line number, window viewing and formatting
set number                  " show line number
set nowrap                  " no auto wrap text line
set fo-=t                   " don't autowrap while typing
set showmatch               " show matching brackets
set wildmode=list:longest   " make commmand completiton work like in shell
set scrolloff=4             " see more context around cursor
set lazyredraw              " don't redraw while executing macros
set visualbell              " turn the 'beep' sound off
set showcmd                 " show visual-mode line selection count
set foldenable              " enalbe folding
set foldmethod=syntax       " fold by syntax
set foldcolumn=1            " display fold indicator

"" color scheme
set background=dark     " background color brightness
colorscheme evening
" colorscheme darkblue
" colorscheme torte

" keys mappings
let mapleader=","   " comma is easier to get than back-slash

" easy quit window
nnoremap <Leader>q :q<cr>

" moving around multiple windows more easyly
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-l><C-w>l

" visual mode shift without loosing selection
vmap < <gv
vmap > >gv

" Syntax highlight (these setting need restarting vim)
filetype off " this required by some plugins, i.e. pathogen
filetype plugin on
filetype indent on
syntax on

" Tabs and r/l shift
set tabstop=4       " mostly of my work I use 4 space indentation
set softtabstop=4   " count 4 spaces as a tab
set expandtab       " replace tab with spaces in normal mode
set shiftwidth=2    " shift 2 spaces each time (when reindent/autoindent)

set smarttab        " work fluently with spaces as tab
set shiftround      " round indent to multiple of shiftwidth
set autoindent      " auto indent on next line insertion
set smartindent     " adj indent dept to where it should be

" Searching
set hlsearch        " highlight current search keyword
set incsearch       " use incremental search
set ignorecase      " case insensitive search
set smartcase       " use smartcase

" I don't want to clean backup file so don't create it.
set nobackup
set nowritebackup
set noswapfile

" plugins management is done via vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"" My Bundles : syntax as follows
"" original repos on github
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"" vim-scripts repos
" Bundle 'FuzzyFinder'
"" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

"" General plugins

"" code commenting
Bundle 'tomtom/tcomment_vim.git'

"" git plugins
Bundle 'tpope/vim-fugitive'

" vimrepress for bloging with wordpress
Bundle 'vim-scripts/VimRepress.git'

" NerdTree
Bundle 'scrooloose/nerdtree.git'
noremap <Leader>nt :NERDTree<cr>

" vim-powerline
Bundle 'Lokaltog/vim-powerline.git'
set laststatus=2    " Always show the statusline
set encoding=utf-8  " Necessary to show unicode glyphs

"" Filetype specific plugins

" edittings for python-mode
Bundle 'klen/python-mode'
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
map <Leader>g :call RopeGotoDefinition()<CR>

" reStructuredText
autocmd FileType rst nnoremap <Leader>v :!gnome-open /tmp/%<.pdf<CR><C-l>
autocmd FileType rst nnoremap <Leader>c :w<CR> :!rst2pdf % -o /tmp/%<.pdf<CR><C-l>

" bash script
autocmd FileType sh nnoremap <Leader>r :w<CR> :source %<CR><C-l>

" haskel source
" Bundle 'Twinside/vim-haskellConceal.git'
" Bundle 'Twinside/vim-haskellFold.git'
autocmd FileType haskell nnoremap <Leader>r :w<CR> :!runhaskell % && echo && read -p "<bash>Enter to exit"<CR><C-l>

"" Misc and custom functions

" custom completion by Tap (code taken form 'Hacking vim' book)
set completeopt=longest,menuone
function! SuperCleverTab()
    "check if at beginning of line or after a space
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return ",<Tab>"
    else
        " do we have omni completion available
        if &omnifunc != ''
            " use omni-completion first
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            " no omni completion, try dictionary completio
            return “\<C-K>”
        else
            " no omni completion nor dictionary completion
            " use known-word completiton
            return "\<C-N>"
        endif
    endif
endfunction
" bind SuperCleverTab function to the <leader>tab key
inoremap <Leader><Tab> <C-R>=SuperCleverTab()<cr>
