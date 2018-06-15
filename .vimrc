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

" Git Gutter
let g:gitgutter_realtime=1
set updatetime=250

" Syntax Highlighting
if (has("termguicolors"))
  set termguicolors
endif

set background=dark

if $TERM == "xterm-256color"
  set t_Co=256
endif

syntax enable
let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Font
set guifont="Roboto Mono":h14

" Formatting
filetype plugin indent on
set foldmethod=manual

" Javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Markdown
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_folding_disabled = 1

" Completion
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_at_startup = 1

" Search
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --hidden\ --smart-case"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set wildignore+=*/tmp/*,*.swp,*/node_modules/*

" Lightline
let g:lightline = {
  \ 'colorscheme': 'oceanicnext',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['relativepath']
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['filetype']
  \     ]
  \   }
  \}

" Testing
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
set shiftwidth=2
set showcmd       " display incomplete commands
set splitbelow
set splitright
set tabstop=2
set wildmode=list:longest,list:full
set textwidth=80
set colorcolumn=+1
set tags=tags;~
set noshowmode
set noruler

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

" Rubocop and eslint autofix
autocmd FileType javascript map <silent> <buffer> <leader>p :NeomakeSh!eslint --fix %<CR>:sleep 1<CR>:e<CR>
autocmd FileType ruby map <silent> <buffer> <leader>p :NeomakeSh!rubocop --auto-correct %<CR>:sleep 1<CR>:e<CR>
autocmd! BufWritePost,BufEnter * Neomake

" Bindings
if filereadable(expand("~/.vim/bindings"))
  source ~/.vim/bindings
endif

" Filetypes
augroup filetypedetect
  au BufRead,BufNewFile *.p8 setfiletype lua
augroup END

" CTags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

function! ReindexCtags()
  let l:ctags_root = system('git rev-parse --show-toplevel')[:-2]
  let l:ctags_hook = l:ctags_root. '/.git/hooks/ctags'

  if filereadable(l:ctags_hook)
    exec '!'. l:ctags_hook
  else
    exec "!ctags -R ."
  endif
endfunction

nmap <Leader>ct :call ReindexCtags()<CR><CR>

" Pasting
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Repl()
