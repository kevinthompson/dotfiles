" Settings
" ==============================
runtime macros/matchit.vim

" Packages
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Clipboard
if $TMUX == ''
  set clipboard+=unnamed
end

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

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287


" Functions
" ==============================
function! ToggleBackground()
  let &background = ( &background == "dark"? "light" : "dark" )
  if exists("g:colors_name")
    exe "colorscheme " . g:colors_name
  endif
  silent !clear
  execute "!reattach-to-user-namespace profile " . ( &background == "dark"? "dark" : "light" )
endfunction

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
    set norelativenumber
  else
    set relativenumber
  endif
endfunc


" Bindings
" ==============================

" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Rspec
nnoremap <Leader>a :call RunAllSpecs()<CR>
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Switch between last two files
nnoremap <leader><leader> <c-^>

" Toggle Relative/Absolute numbers
nnoremap <C-n> :call NumberToggle()<cr>
noremap <silent> <F12> :call ToggleBackground()<CR><CR>

" Inline Ruby Processing
noremap <buffer> <F5> <Plug>(xmpfilter-run)
noremap <buffer> <F4> <Plug>(xmpfilter-mark)

" Tab Completion
inoremap <Tab> <c-r>=AutocompleteTabWrapper()<cr>
inoremap <s-Tab> <c-r>=snipMate#TriggerSnippet()<cr>
snoremap <s-Tab> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>

map <Leader>h :noh<CR>
map <Leader>ct :!ctags -R .<CR>
map <Leader>: :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>:noh<CR>


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

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

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


" Go Lang
" =============================
set runtimepath+=$GOROOT/misc/vim
autocmd FileType go autocmd BufWritePre <buffer> Fmt
