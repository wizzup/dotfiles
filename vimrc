" .vimrc by Wisut Hantanong
 
"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/wisut/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/wisut/.vim/bundle'))

" Let NeoBundle manage NeoBundleCompleted.
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'

" Python completion
NeoBundle 'davidhalter/jedi-vim'

" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

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
"set visualbell              " turn the 'beep' sound off

"" color scheme
set background=dark     " background color brightness
colorscheme evening

" keys mappings
set pastetoggle=<F12>
let mapleader=","   " comma is easier to get than back-slash

" folding
" fold toggle using space
"nmap <Space> za

" moving around multiple windows more easyly
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-l><C-w>l

" visual mode shift without loosing selection
vmap < <gv
vmap > >gv

" Syntax highlight (these setting need restarting vim)
"filetype off " this required by some plugins, i.e. pathogen
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
"set ignorecase      " case insensitive search
set smartcase       " use smartcase

" I don't want to clean backup file so don't create it.
set nobackup
set nowritebackup
set noswapfile

"" ================================================================================
"" AUTO COMMAND
"" ================================================================================
"" Put these in an autocmd group, so that we can delete them easily.
"augroup vimrcEx
"au!

" reStructuredText
"autocmd FileType rst nmap <Leader>v :!xdg-open /tmp/%<.pdf<CR><C-l>
"autocmd FileType rst nmap <Leader>c :w<CR> :!rst2pdf % -o /tmp/%<.pdf<CR><C-l>

" bash script
"autocmd FileType sh nmap <Leader>r :w<CR> :source %<CR><C-l>

" haskel source
" autocmd BufEnter *.hs compiler ghc
"autocmd FileType haskell nmap <Leader>r :w<CR> :!runhaskell % && echo && read -p "<bash>Enter to exit"<CR><C-l>

" For all text files set 'textwidth' to 78 characters.
"autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
"autocmd BufReadPost *
"\ if line("'\"") > 1 && line("'\"") <= line("$") |
"\   exe "normal! g`\"" |
"\ endif

"augroup END

"" ================================================================================
"" Misc and custom functions
"" ================================================================================

" custom completion by Tap (code taken form 'Hacking vim' book)
"set completeopt=longest,menuone
"function! SuperCleverTab()
"    "check if at beginning of line or after a space
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"        return ",<Tab>"
"    else
"        " do we have omni completion available
"        if &omnifunc != ''
"            " use omni-completion first
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            " no omni completion, try dictionary completio
"            return “\<C-K>”
"        else
"            " no omni completion nor dictionary completion
"            " use known-word completiton
"            return "\<C-N>"
"        endif
"    endif
"endfunction
" bind SuperCleverTab function to the <leader>tab key
"imap <Leader><Tab> <C-R>=SuperCleverTab()<cr>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
"if !exists(":DiffOrig")
"  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		 " \ | wincmd p | diffthis
"endif
