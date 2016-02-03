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
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif
colorscheme solarized
filetype plugin indent on

" Use the Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in ctrlp for listing files. lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Settings
let g:enable_bold_font = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:airline_theme='solarized'
let g:html_indent_tags = 'li\|p'
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec --color --format documentation {spec}\n")'
let g:solarized_termtrans=1
let g:syntastic_check_on_open=1
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

set guifont=Monaco:h12
set background=dark
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
set relativenumber

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
autocmd! BufWritePost * Neomake

" Relative Numbers
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

" Fast Escape
"if ! has('gui_running')
"  set ttimeoutlen=10
"  augroup FastEscape
"    autocmd!
"    au InsertEnter * set timeoutlen=0
"    au InsertLeave * set timeoutlen=1000
"  augroup END
"endif

" Bindings
if filereadable(expand("~/.vim/bindings"))
  source ~/.vim/bindings
endif
