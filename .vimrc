" Settings
" ==============================
nnoremap <SPACE> <Nop>

" Packages
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Clipboard
set clipboard+=unnamed

" Syntax Highlighting
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif
colorscheme solarized

" Use the Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in ctrlp for listing files. lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

filetype plugin indent on

let mapleader = " "
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:airline_theme='solarized'
let g:html_indent_tags = 'li\|p'
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec --color --format documentation {spec}\n")'
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let g:snippetsEmu_key = "<S-Tab>"
let g:solarized_termtrans=1
let g:syntastic_check_on_open=1
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

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

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287


" Functions
" ==============================
function! AutocompleteTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

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
" ==============================
autocmd QuickFixCmdPost *grep* cwindow

" Remove Trailing Whitespace
autocmd BufWritePre * call StripTrailingWhitespace()

" Relative Numbers
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.conf set filetype=javascript
  autocmd BufRead,BufNewFile *.region set filetype=html
  autocmd BufRead,BufNewFile *.item set filetype=html
  autocmd BufRead,BufNewFile *.list set filetype=html
  autocmd BufRead,BufNewFile *.s set filetype=armasm
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Fast Escape
" =============================
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Bindings
" ==============================
if filereadable(expand("~/.vimrc.bindings"))
  source ~/.vimrc.bindings
endif
