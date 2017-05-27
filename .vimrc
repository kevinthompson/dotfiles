" Settings
" ==============================

" Leader
noremap   <space>    <NOP>
let mapleader="\<space>"

" Packages
if filereadable(expand("~/.vim/plugins"))
  source ~/.vim/plugins
endif

" Clipboard
set clipboard+=unnamed

" Syntax Highlighting
let g:onedark_termcolors=16
syntax on
colorscheme onedark
set background=dark
set guifont="Roboto Mono":h13
filetype plugin indent on

" Javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Search
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

let g:ackprg = 'rg --vimgrep --no-heading'

set wildignore+=*/tmp/*,*.swp,*/node_modules/*

" Settings
let g:lightline = { 'colorscheme': 'onedark' }

" Testing
function! BoxTransform(cmd) abort
  return 'box '.a:cmd
endfunction

let g:test#custom_transformations = {'box': function('BoxTransform')}
let g:test#transformation = 'box'
let test#strategy = 'tslime'

set complete=.,w,t
set expandtab
set hidden
set history=50
set hlsearch
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set list listchars=tab:»·,trail:·
set nowrap
set number
set numberwidth=5
set ruler         " show the cursor position all the time
set shiftwidth=2
set showcmd       " display incomplete commands
set splitbelow
set splitright
set tabstop=2
set wildmode=list:longest,list:full
set textwidth=80
set colorcolumn=+1
set tags=tags;~

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Functions
function! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun

function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Auto Commands
autocmd QuickFixCmdPost *grep* cwindow
autocmd BufWritePre * call StripTrailingWhitespace()

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" Bindings
if filereadable(expand("~/.vim/bindings"))
  source ~/.vim/bindings
endif
